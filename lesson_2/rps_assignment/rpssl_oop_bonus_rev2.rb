# rpssl_oop_bonus_rev2.rb

module RPSSL
  RPSSL_LOGIC = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['scissors', 'rock'],
    'lizard' => ['spock', 'paper']
  }

  PLAYS = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  def clear_screen
    system 'clear'
    system 'cls'
  end
end

# class Move
#   include RPSSL
#   attr_reader :value

#   def initialize(value)
#     @value = value
#   end

#   def to_s
#     @value
#   end
# end

class Player
  attr_accessor :move, :name, :score

  include RPSSL

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      clear_screen
      puts "\n\nPlease enter your name:"
      n = gets.chomp
      break unless n.empty?
      puts "I'm sorry, you must enter a value."
    end
    self.name = n
    clear_screen
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp.downcase
      break if RPSSL::PLAYS.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
    # self.move = Move.new(choice)
    clear_screen
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Alpha Go', 'Sonny', 'C3PO'].sample
  end

  def choose
    self.move = RPSSL::PLAYS.sample
    # self.move = Move.new(RPSSL::PLAYS.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  include RPSSL

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard, #{human.name}!"
  end

  def display_goodbye_message
    puts "Thank you for playing Rock, Paper, Scissors, Spock, Lizard. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def scored(winner)
    winner.score += 1
    puts "#{winner.name} won!"
    puts
  end

  def display_winner
    if RPSSL_LOGIC[human.move].include?(computer.move)
      scored(human)
    elsif RPSSL_LOGIC[computer.move].include?(human.move)
      scored(computer)
    else
      puts "It's a tie!"
    end
  end

  def match_score
    puts "*** Match Score ***"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts
  end

  def match_winner?
    human.score == 5 || computer.score == 5
  end

  def congrats
    if human.score == 5
      puts "#{human.name} wins the match!"
    else
      puts "#{computer.name} wins the match!"
    end
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "I'm sorry, you musy choose y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play_round
    human.choose
    computer.choose
    display_moves
    display_winner
  end

  def play_match
    display_welcome_message
    loop do
      play_round
      match_score
      break if match_winner?
    end
    congrats
    play_again? ? RPSGame.new.play_match : display_goodbye_message
  end
end

RPSGame.new.play_match
