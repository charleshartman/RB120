# rpssl_oop_bonus_rev3.rb

module RPSSL
  RPSSL_LOGIC = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['scissors', 'rock'],
    'lizard' => ['spock', 'paper']
  }

  INPUT_CHAR = { 'r' => 'rock',
                 'p' => 'paper',
                 'sc' => 'scissors',
                 'sp' => 'spock',
                 'l' => 'lizard' }

  PLAYS = %w(rock paper scissors spock lizard)

  def clear_screen
    system 'clear'
    system 'cls'
  end
end

class History
  attr_accessor :moves_log

  def initialize
    @moves_log = []
  end
end

class Player
  attr_accessor :name, :move, :score

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
      puts "\nPlease enter your name:"
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
      puts "Please choose (r)ock, (p)aper, (sc)issors, (sp)ock or (l)izard:"
      choice = INPUT_CHAR[gets.chomp.downcase]
      break if RPSSL::PLAYS.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
    clear_screen
  end
end

class AlphaGo < Player
  def set_name
    self.name = 'Alpha Go'
  end

  def choose
    self.move = RPSSL::PLAYS.sample
  end
end

class R2D2 < Player
  def set_name
    self.name = 'R2D2'
  end

  def choose
    self.move = 'rock'
  end
end

class Hal < Player
  def set_name
    self.name = 'Hal'
  end

  def choose
    self.move = %w(rock paper scissors lizard scissors scissors scissors
                   scissors).sample
  end
end

class K2SO < Player
  def set_name
    self.name = 'K-2SO'
  end

  def choose
    self.move = %w(paper paper paper spock lizard lizard lizard scissors
                   scissors).sample
  end
end

# Game Orchestration Engine
class RPSGame
  include RPSSL

  def initialize
    @human = Human.new
    @computer = [R2D2.new, AlphaGo.new, Hal.new].sample
    @log = History.new
  end

  def display_welcome_message
    puts "\nWelcome to Rock, Paper, Scissors, Spock, Lizard, " \
         "\e[32m#{human.name}\e[0m!"
    puts "Win \e[32m5\e[0m games to win the match!"
    puts "\e[32m#{computer.name}\e[0m is your opponent.\n"
  end

  def display_goodbye_message
    puts "\nThank you for playing Rock, Paper, Scissors, Spock, Lizard."
    puts
    puts "Here is the log of all the moves from your play session:"
    puts
    display_log
    puts "\nGoodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    log.moves_log << [human.move, computer.move]
  end

  def display_log
    log.moves_log.each do |sub|
      puts "\e[32m#{human.name}\e[0m: #{sub.first} | \e[32mComputer:\e[0m " \
         + sub.last.to_s
    end
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

  def congratulations
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

  def play_continues
    @computer = [R2D2.new, AlphaGo.new, Hal.new, K2SO.new].sample
    puts "\n\e[32mReseting all scores to zero...\e[0m"
    sleep 1.5
    human.score = 0
    computer.score = 0
    puts "\e[32mNew Game Loading...\e[0m"
    sleep 1.5
    clear_screen
    play_match
  end

  def play_match
    display_welcome_message
    loop do
      play_round
      match_score
      break if match_winner?
    end
    congratulations
    play_again? ? play_continues : display_goodbye_message
  end

  protected

  attr_accessor :human, :computer, :log
end

RPSGame.new.play_match
