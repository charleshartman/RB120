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

  def continue
    print "\e[34m[Press any key to continue]\e[0m"
    STDIN.getch
    print "                            \r"
  end
end

module Hand
  # code
end

class Participant
  include Blackjack

  attr_accessor :name, :hand, :hand_total, :match_score

  def initialize
    @name = name
    @hand = []
    @hand_total = 0
    @match_score = 0
  end

  def reset_hand
    self.hand = []
  end

  def reset_hand_total
    self.hand_total = 0
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
    self.name = %w(Jack Emily Conan Joan Seth).sample
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

  def size
    cards.size
  end

  def deal(num = 1)
    cards.shift(num)
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
    display_introduction_names
    loop do
      display_welcome_message
      main_game
      break
      # display_match_winner
      # play_again? ? play_continues : break
    end

    display_goodbye_message
  end

  def main_game
    deal_cards
    # check_state
    show_initial_cards
    player_turn
    # dealer_turn
    # show_result
    # break if match_win?
    # reset_game
  end

  def deal_cards
    @deck = Deck.new
    display_new_round
    player.hand.concat(deck.deal(2))
    dealer.hand.concat(deck.deal(2))
  end

  def show_initial_cards
    puts starting_hand_hidden
    puts starting_hand_visible
  end

  def starting_hand_hidden
    "Dealer has [#{dealer.hand[0][1]} of #{SYMBOLS[dealer.hand[0][0]]}] " \
       "and [hidden].\n\n"
  end

  def starting_hand_visible
    "Player has [#{player.hand[0][1]} of #{SYMBOLS[player.hand[0][0]]}] " \
       "and [#{player.hand[1][1]} of #{SYMBOLS[player.hand[1][0]]}].\n\n"
  end

  def display_onboarding_hello
    clear_screen
    prompt_purple("Twenty-One Game Setup...")
    sleep 1.25
    prompt_purple("Just a few questions before we begin...")
    sleep 1.25
  end

  def display_welcome_message
    clear_screen
    puts ''
    prompt_green("Welcome to '#{HIGH_SCORE}' inspired by [Blackjack].\n")
    prompt_green("Single Deck Shoe. Dealer must HIT below #{DEALER_HITS_TO}.")
    prompt_green("First to Win #{MATCH_GAMES} Hands Wins the Match!\n")
    prompt_green("Good Luck!\n")
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

  def display_introduction_names
    puts ''
    prompt_green("Welcome, #{player.name}!")
    prompt_green("Your dealer today is #{dealer.name}.\n")
    prompt_green("Let's get started...\n")
    continue
  end

  def display_new_round
    clear_screen
    puts ''
    prompt_green("Shuffling...")
    sleep 1.50
    prompt_green("Dealing...\n")
    sleep 1.00
  end

  def player_turn
    loop do
      answer = player_hit_or_stay
      if answer == 'h'
        hit(player)
        player.hand_total = player.total
        display_hand_total(player)
      end

      break if answer == 's' # || busted?(player_total)
    end
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

  def stay; end

  def busted?; end

  def display_hand_total(who)
    puts "The total of the #{who.name}'s hand is #{who.hand_total}.\n\n"
    sleep 0.75
  end

  def reset_game
    player.reset_hand
    dealer.reset_hand
    player.reset_hand_total
    dealer.reset_hand_total
  end

  def match_win?
    player.match_score == MATCH_GAMES || dealer.match_score == MATCH_GAMES
  end

  def check_state
    p player.hand
    p dealer.hand
    p deck.size
    p deck.cards
  end
end

TwentyOneGame.new.play
