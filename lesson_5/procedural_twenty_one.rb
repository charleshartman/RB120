# procedural_twenty_one.rb
# source: my Twenty-One Bonus Features Assignment from RB101
# Whatever-One also implemented

require 'io/console'

SUITS = ['H', 'D', 'S', 'C']
CARDS = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10',
         'Jack', 'Queen', 'King']
VALUES = { 'Ace' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10, "Jack" => 10,
           'Queen' => 10, 'King' => 10 }
SYMBOLS = { "S" => "\u2660", "H" => "\u2665", "D" => "\u2666", "C" => "\u2663" }

# set these to modify gameplay parameters, 21 and 17 are traditional
HIGH_SCORE = 21
DEALER_HITS_TO = 17

def clear_screen
  system 'clear'
  system 'cls'
end

def prompt(msg)
  puts "\e[34m#{msg}\e[0m"
end

def prompt_green(msg)
  puts "\e[32m#{msg}\e[0m"
end

def display_initial_welcome
  clear_screen
  puts ''
  prompt_green("Welcome to '#{HIGH_SCORE}' inspired by [Blackjack].")
  puts ''
  prompt_green("Single Deck Shoe. Dealer must HIT below #{DEALER_HITS_TO}.")
  prompt_green("First to Win 5 Hands Wins the Match!")
  puts ''
  prompt_green("Good Luck!")
  puts ''
  prompt("[Press any key to begin]")
  STDIN.getch
end

def display_new_round
  clear_screen
  puts ''
  prompt_green("Shuffling...")
  sleep 1.50
  prompt_green("Dealing...\n")
  sleep 1.00
end

def deck_builder(suits, cards)
  fresh_deck = []
  suits.each do |suit|
    cards.each do |card|
      fresh_deck << [suit, card]
    end
  end

  fresh_deck.shuffle
end

def initial_deal(deck, player_hand, dealer_hand)
  2.times do
    deal_card(deck, player_hand)
    deal_card(deck, dealer_hand)
  end
end

def deal_card(deck, hand)
  hand << deck.shift
end

def total_hand(hand)
  values = hand.map { |card| card[1] }
  total = 0
  hand.each { |val| total += VALUES[val[1]] }
  values.select { |val| val == 'Ace' }.count.times do
    total -= 10 if total > HIGH_SCORE
  end
  total
end

def display_hand_total(who, total)
  puts "The total of the #{who}'s hand is #{total}.\n\n"
  sleep 0.75
end

def display_current_score(dealer_total, player_total)
  puts "Dealer total is #{dealer_total}, player total is #{player_total}.\n\n"
end

def busted?(total)
  total > HIGH_SCORE
end

def play_again?
  answer = ''
  loop do
    prompt("Would you like to play another match? (y/n) ")
    answer = gets.chomp.downcase
    break if answer == 'y' || answer == 'n'
    puts "=> Invalid input, you must enter 'y' or 'n'.\n\n"
  end
  true if answer == 'y'
end

def continue_playing?
  print "[Press any key to continue]"
  STDIN.getch
  print "                            \r"
end

def who_wins?(dealer_total, player_total)
  if player_total > HIGH_SCORE
    :player_bust
  elsif dealer_total > HIGH_SCORE
    :dealer_bust
  elsif dealer_total == player_total
    :push
  elsif dealer_total > player_total
    :dealer
  elsif player_total > dealer_total
    :player
  end
end

def report_result(dealer_total, player_total)
  result = who_wins?(dealer_total, player_total)

  case result
  when :player_bust
    prompt_green("Player busted! Dealer wins!\n")
  when :dealer_bust
    prompt_green("Dealer busted! Player wins!\n")
  when :player
    prompt_green("Player wins!\n")
  when :dealer
    prompt_green("Dealer wins!\n")
  when :push
    prompt_green("Hand is tied, push!\n")
  end
end

def increment_scoreboard(dealer_total, player_total, scoreboard)
  result = who_wins?(dealer_total, player_total)

  case result
  when :player_bust
    scoreboard[:dealer] += 1
  when :dealer_bust
    scoreboard[:player] += 1
  when :player
    scoreboard[:player] += 1
  when :dealer
    scoreboard[:dealer] += 1
  when :push
    scoreboard
  end
end

def print_scoreboard(scoreboard)
  prompt_green("Match score -> Player: #{scoreboard[:player]} " \
               "Dealer: #{scoreboard[:dealer]}  (Score 5 to Win the Match!)\n")
end

def banner(dealer_hand, player_hand, dealer_total, player_total, scoreboard)
  display_current_hand(dealer_hand, player_hand)
  display_current_score(dealer_total, player_total)
  report_result(dealer_total, player_total)
  increment_scoreboard(dealer_total, player_total, scoreboard)
  print_scoreboard(scoreboard)
end

def bunnie(how_many = 1)
  how_many.times do
    puts ''
    prompt("(\\___/)")
    prompt("(='.'=)")
    prompt("(\")_(\")")
    puts ''
  end
end

def match_won?(scoreboard)
  if scoreboard[:player] == 5
    prompt_green("Player has won five rounds! Player wins the match!\n\n")
    prompt("Bunnie '#{HIGH_SCORE}' says 'Good Job!'")
    bunnie
    true
  elsif scoreboard[:dealer] == 5
    prompt_green("Dealer has won five rounds! Dealer wins the match!\n\n")
    true
  else
    false
  end
end

def display_initial_hands(dealer_hand, player_hand)
  puts "Dealer has [#{dealer_hand[0][1]} of #{SYMBOLS[dealer_hand[0][0]]}] " \
       "and [hidden].\n\n"
  puts "Player has [#{player_hand[0][1]} of #{SYMBOLS[player_hand[0][0]]}] " \
       "and [#{player_hand[1][1]} of #{SYMBOLS[player_hand[1][0]]}].\n\n"
end

def display_current_hand(dealer_hand, player_hand)
  print "Dealer hand: "
  dealer_hand.each do |card|
    print "[#{SYMBOLS[card[0]]} #{card[1]} #{SYMBOLS[card[0]]}]  "
  end
  puts ''
  print "Player hand: "
  player_hand.each do |card|
    print "[#{SYMBOLS[card[0]]} #{card[1]} #{SYMBOLS[card[0]]}]  "
  end
  puts ''
end

def player_hit_stay?
  choice = ''
  loop do
    prompt("Would you like to (h)it or (s)tay?")
    choice = gets.chomp.downcase
    break if choice == 's' || choice == 'h'
    puts "=> Invalid input, you must enter 'h' or 's'.\n\n"
  end
  choice
end

def hit_me(player, deck, hand)
  prompt_green("#{player} hits...")
  sleep 1.00
  deal_card(deck, hand)
  puts "#{player} is dealt [#{hand[-1][1]} of " \
       "#{SYMBOLS[hand[-1][0]]}]"
end

def dealer_reveals(dealer_hand, dealer_total)
  prompt_green("Dealer reveals hidden card...the dealer's hand is:")
  sleep 1.00
  puts "[#{dealer_hand[0][1]} of #{SYMBOLS[dealer_hand[0][0]]}] " \
       "and [#{dealer_hand[1][1]} of #{SYMBOLS[dealer_hand[1][0]]}].\n\n"
  puts "The total of the dealer's hand is #{dealer_total}.\n\n"
  sleep 1.00
end

def stays_with(who, who_total)
  sleep 1.50 # comment this out if you uncomment next line
  # continue_playing?
  # ^^^ you can you this instead of sleep for a slower, read
  # all the cards and calculations carefully experience
  clear_screen
  prompt_green("#{who} stays with #{who_total}.\n")
end

loop do
  scoreboard = { player: 0, dealer: 0 }
  display_initial_welcome

  loop do
    player_hand = []
    dealer_hand = []

    display_new_round

    deck = deck_builder(SUITS, CARDS)
    initial_deal(deck, player_hand, dealer_hand)
    display_initial_hands(dealer_hand, player_hand)

    dealer_total = total_hand(dealer_hand)
    player_total = total_hand(player_hand)

    loop do
      answer = player_hit_stay?
      if answer == 'h'
        hit_me('Player', deck, player_hand)
        player_total = total_hand(player_hand)
        display_hand_total('player', player_total)
      end

      break if answer == 's' || busted?(player_total)
    end

    if busted?(player_total)
      banner(dealer_hand, player_hand, dealer_total, player_total, scoreboard)
      continue_playing?
      match_won?(scoreboard) ? break : next
    else
      stays_with('Player', player_total)
    end

    dealer_reveals(dealer_hand, dealer_total)

    loop do
      break if dealer_total >= DEALER_HITS_TO

      hit_me('Dealer', deck, dealer_hand)
      dealer_total = total_hand(dealer_hand)
      display_hand_total('dealer', dealer_total)
    end

    if busted?(dealer_total)
      banner(dealer_hand, player_hand, dealer_total, player_total, scoreboard)
      continue_playing?
      match_won?(scoreboard) ? break : next
    else
      stays_with('Dealer', dealer_total)
    end

    banner(dealer_hand, player_hand, dealer_total, player_total, scoreboard)
    continue_playing?
    match_won?(scoreboard) ? break : next
  end

  break unless play_again?
end

puts ''
prompt_green("Thank you for playing '#{HIGH_SCORE}'. Goodbye.")
