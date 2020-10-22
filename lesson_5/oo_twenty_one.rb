# oo_twenty_one.rb

require 'io/console'

module Blackjack
  SUITS = ['H', 'D', 'S', 'C']
  CARDS = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10',
           'Jack', 'Queen', 'King']

  SYMBOLS = { "S" => "\u2660", "H" => "\u2665", "D" => "\u2666",
              "C" => "\u2663" }

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
  include Hand

  attr_accessor :name, :hand, :hand_total, :match_score

  def initialize
    @name = name
    @hand = []
    @hand_total = 0
    @match_score = 0
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

  def hit; end

  def stay; end

  def busted?; end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer < Participant
  def set_name
    self.name = %w(Jack Emily Conan Joan Seth).sample
  end

  def hit; end

  def stay; end

  def busted?; end

  def total; end
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

class Card
  def initialize
    # what are the "states" of a card?
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
    display_initial_welcome
    assign_participant_names
    display_introduction_names
  end

  def main_game
    deal_cards
    # check_state
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  def deal_cards
    @deck = Deck.new
    player.hand.concat(deck.deal(2))
    dealer.hand.concat(deck.deal(2))
  end

  def show_initial_cards
    puts_purple(starting_hand_hidden)
    puts_purple(starting_hand_visible)
  end

  def starting_hand_hidden
    "Dealer has [#{dealer.hand[0][1]} of #{SYMBOLS[dealer.hand[0][0]]}] " \
       "and [hidden].\n\n"
  end

  def starting_hand_visible
    "Player has [#{player.hand[0][1]} of #{SYMBOLS[player.hand[0][0]]}] " \
       "and [#{player.hand[1][1]} of #{SYMBOLS[player.hand[1][0]]}].\n\n"
  end

  def display_initial_welcome
    clear_screen
    puts ''
    prompt_green("Welcome to '#{HIGH_SCORE}' inspired by [Blackjack].\n")
    prompt_green("Single Deck Shoe. Dealer must HIT below #{DEALER_HITS_TO}.")
    prompt_green("First to Win #{MATCH_GAMES} Hands Wins the Match!\n")
    prompt_green("Good Luck!\n")
    prompt_purple("[Press any key to begin]")
    STDIN.getch
  end

  def assign_participant_names
    clear_screen
    player.set_name
    dealer.set_name
  end

  def display_introduction_names
    clear_screen
    puts ''
    prompt_green("Welcome, #{player.name}!\n")
    prompt_green("Your dealer's name is #{dealer.name}.\n")
    prompt_green("Let the games begin!\n")
    continue
  end

  def check_state
    p player.hand
    p dealer.hand
    p deck.size
    p deck.cards
  end
end

TwentyOneGame.new.play
