# oo_twenty_one.rb

require 'io/console'

module Blackjack
  SUITS = ['H', 'D', 'S', 'C']
  CARDS = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10',
           'Jack', 'Queen', 'King']

  SYMBOLS = { "S" => "\u2660", "H" => "\u2665", "D" => "\u2666",
              "C" => "\u2663" }

  VALUES = { 'Ace' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
             '7' => 7, '8' => 8, '9' => 9, '10' => 10, "Jack" => 10,
             'Queen' => 10, 'King' => 10 }

  # set to determine how many games win the match
  MATCH_GAMES = 5
  # set these to modify gameplay parameters, 21 and 17 are traditional
  HIGH_SCORE = 21
  DEALER_HITS_TO = 17

  def clear_screen
    system 'clear'
    system 'cls'
  end

  def prompt_purple(msg)
    puts "\e[34m#{msg}\e[0m"
  end

  def prompt_green(msg)
    puts "\e[32m#{msg}\e[0m"
  end

  def continue_prompt
    print "\e[34m[Press any key to continue]\e[0m"
    STDIN.getch
    print "                            \r"
  end

  def blackjack_bunnie(how_many = 1)
    how_many.times do
      puts ''
      prompt_purple("(\\___/)")
      prompt_purple("(='.'=)")
      prompt_purple("(\")_(\")")
      puts ''
    end
  end
end

class Participant
  include Blackjack

  attr_accessor :name, :hand, :match_score
  attr_writer :total

  def initialize
    @name = name
    @hand = []
    @total = 0
    @match_score = 0
  end

  def reset_hand
    self.hand = []
  end

  def reset_total
    self.total = 0
  end

  def busted?
    total > HIGH_SCORE
  end

  def stay
    sleep 1.00
    clear_screen
    prompt_green("#{name} stays with #{total}.\n")
  end

  def bust_or_stay
    if busted?
      prompt_green("It's a bust!\n")
      continue_prompt
      clear_screen
    else
      stay
    end
  end

  def total
    values = hand.map { |card| card[1] }
    total = 0
    hand.each { |val| total += VALUES[val[1]] }
    values.select { |val| val == 'Ace' }.count.times do
      total -= 10 if total > HIGH_SCORE
    end
    total
  end

  def display_hand
    print "#{name}'s hand: "
    hand.each do |card|
      print "[#{SYMBOLS[card[0]]} #{card[1]} #{SYMBOLS[card[0]]}]  "
    end
    puts ''
  end

  def display_total
    puts "The total of the #{name}'s hand is #{total}.\n\n"
    sleep 0.75
  end
end

class Player < Participant
  def set_name
    n = ''
    loop do
      puts "\nPlease enter your name:"
      n = gets.chomp
      break unless n.delete(' ').empty?
      puts "I'm sorry, you must enter a value."
    end
    self.name = n.squeeze(' ')
  end
end

class Dealer < Participant
  def set_name
    self.name = 'Dealer'
  end
end

class Deck
  include Blackjack

  attr_accessor :cards

  def initialize
    @cards = []
    deck_builder
  end

  def deck_builder
    SUITS.each do |suit|
      CARDS.each do |card|
        @cards << [suit, card]
      end
    end

    cards.shuffle!
  end

  def deal(card = 1)
    cards.shift(card)
  end
end

class TwentyOneGame
  include Blackjack

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def play
    display_onboarding_hello
    assign_participant_names
    loop do
      display_welcome_message
      main_game
      display_match_winner
      play_again ? play_continues : break
    end

    display_goodbye_message
  end

  private

  def main_game
    loop do
      deal_cards
      show_initial_cards
      take_turns
      display_all_stats
      continue_prompt
      break if match_win?
      reset_game
    end
  end

  def take_turns
    player_turn
    return if player.busted?
    dealer_turn
  end

  def deal_cards
    @deck = Deck.new
    display_new_round
    player.hand.concat(deck.deal(2))
    dealer.hand.concat(deck.deal(2))
  end

  def show_initial_cards
    puts dealer_starting_hand
    puts player_starting_hand
  end

  def dealer_starting_hand
    "Dealer has [#{dealer.hand[0][1]} of #{SYMBOLS[dealer.hand[0][0]]}] " \
       "and [hidden].\n\n"
  end

  def player_starting_hand
    "Player has [#{player.hand[0][1]} of #{SYMBOLS[player.hand[0][0]]}] " \
       "and [#{player.hand[1][1]} of #{SYMBOLS[player.hand[1][0]]}].\n\n"
  end

  def display_onboarding_hello
    clear_screen
    puts ''
    prompt_purple("Twenty-One Game Setup...")
    sleep 1.25
  end

  def display_welcome_message
    clear_screen
    puts ''
    prompt_green("Welcome to '#{HIGH_SCORE}' inspired by [Blackjack].\n")
    prompt_green("Single Deck Shoe. Dealer must HIT below #{DEALER_HITS_TO}.")
    prompt_green("First to Win #{MATCH_GAMES} Hands Wins the Match!\n")
    prompt_green("Good Luck, #{player.name}!\n")
    prompt_purple("[Press any key to begin]")
    STDIN.getch
  end

  def display_goodbye_message
    prompt_green("Thank you for playing '#{HIGH_SCORE}'. Goodbye.")
  end

  def assign_participant_names
    player.set_name
    dealer.set_name
  end

  def display_new_round
    clear_screen
    puts ''
    prompt_green("Shuffling...")
    sleep 1.25
    prompt_green("Dealing...\n")
    sleep 1.00
  end

  def player_turn
    loop do
      answer = player_hit_or_stay
      if answer == 'h'
        hit(player)
        player.display_total
      end

      break if answer == 's' || player.busted?
    end

    player.bust_or_stay
  end

  def dealer_turn
    dealer_reveals

    loop do
      break if dealer.total >= DEALER_HITS_TO

      hit(dealer)
      dealer.display_total
    end

    dealer.bust_or_stay
  end

  def player_hit_or_stay
    choice = ''
    loop do
      prompt_purple("Would you like to (h)it or (s)tay?")
      choice = gets.chomp.downcase
      break if choice == 's' || choice == 'h'
      puts "=> Invalid input, you must enter 'h' or 's'.\n\n"
    end
    choice
  end

  def hit(who)
    prompt_green("#{who.name} hits...")
    sleep 1.00
    who.hand.concat(deck.deal)
    puts "#{who.name} is dealt [#{who.hand[-1][1]} of " \
         "#{SYMBOLS[who.hand[-1][0]]}]"
  end

  def dealer_reveals
    prompt_green("#{dealer.name} reveals hidden card...")
    sleep 1.00
    dealer.display_hand
    dealer.display_total
    sleep 1.00
  end

  def display_match_winner
    if player.match_score == 5
      prompt_green("#{player.name} has won #{MATCH_GAMES} rounds! " \
        "#{player.name} wins the match!\n")
      prompt_purple("Bunnie '#{HIGH_SCORE}' says 'Good Job!'")
      blackjack_bunnie
    elsif dealer.match_score == 5
      prompt_purple("#{dealer.name} has won #{MATCH_GAMES} rounds! " \
         "#{dealer.name} wins the match!\n")
    end
  end

  def display_current_score
    puts "#{dealer.name}'s total is #{dealer.total}, #{player.name}'s total " \
         "is #{player.total}.\n\n"
  end

  def display_current_hand
    dealer.display_hand
    player.display_hand
  end

  def display_all_stats
    display_current_hand
    display_current_score
    report_result
    increment_match_score
    display_match_score
  end

  def who_wins
    if player.total > HIGH_SCORE then :player_bust
    elsif dealer.total > HIGH_SCORE then :dealer_bust
    elsif dealer.total > player.total then :dealer
    elsif player.total > dealer.total then :player
    else :push
    end
  end

  def report_result
    result = who_wins

    case result
    when :player_bust then prompt_green("Player busted! Dealer wins!\n")
    when :dealer_bust then prompt_green("Dealer busted! Player wins!\n")
    when :player then prompt_green("Player wins!\n")
    when :dealer then prompt_green("Dealer wins!\n")
    when :push then prompt_green("Hand is tied, push!\n")
    end
  end

  def increment_match_score
    result = who_wins

    dealer.match_score += 1 if result == :player_bust || result == :dealer
    player.match_score += 1 if result == :dealer_bust || result == :player
  end

  def display_match_score
    prompt_green("Match score -> #{player.name}: #{player.match_score} | " \
      "#{dealer.name}: #{dealer.match_score}  (Win #{MATCH_GAMES} rounds to " \
      "win the match!)\n")
  end

  def reset_game
    player.reset_hand
    dealer.reset_hand
    player.reset_total
    dealer.reset_total
  end

  def match_win?
    player.match_score == MATCH_GAMES || dealer.match_score == MATCH_GAMES
  end

  def play_again
    answer = nil
    loop do
      puts "\nGame Over! Start a new match? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Invalid entry. Please enter y or n only."
    end

    answer == 'y'
  end

  def play_continues
    dealer.match_score = 0
    player.match_score = 0
    reset_game
  end
end

TwentyOneGame.new.play
