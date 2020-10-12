# rpssl_oop_bonus_rev3.rb

module RPSSL
  RPSSL_LOGIC = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['scissors', 'rock'],
    'lizard' => ['spock', 'paper']
  }

  PLAYS = { 'r' => 'rock',
            'p' => 'paper',
            'sc' => 'scissors',
            'sp' => 'spock',
            'l' => 'lizard' }

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
  attr_accessor :name, :move, :score, :message

  include RPSSL

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ""
    clear_screen
    loop do
      puts "\nPlease enter your name:"
      n = gets.chomp
      break unless n.delete(' ').empty?
      puts "I'm sorry, you must enter a value."
    end
    self.name = n.squeeze(' ')
    clear_screen
  end

  def choose
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (sc)issors, (sp)ock or (l)izard:"
      choice = PLAYS[gets.chomp.downcase]
      break if PLAYS.values.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
    clear_screen
  end
end

class AlphaGo < Player
  def set_name
    self.name = 'AlphaGo'
  end

  def message
    self.message = 'My intellect is legendary.'
  end

  def choose
    self.move = PLAYS.values.sample
  end
end

class R2D2 < Player
  def set_name
    self.name = 'R2D2'
  end

  def message
    self.message = 'I like holograms, bathing, rocks and C3PO (in that order).'
  end

  def choose
    self.move = 'rock'
  end
end

class Hal < Player
  def set_name
    self.name = 'Hal'
  end

  def message
    self.message = 'A stitch in time saves 9000, Dave.'
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

  def message
    self.message = "When I am not writing the most popular Star Trek " \
                   "newsletter \non Tatooine, I enjoy the company of my pet " \
                   "iguana."
  end

  def choose
    self.move = %w(paper paper paper spock lizard lizard lizard spock).sample
  end
end

# Game Orchestration Engine
class RPSGame
  include RPSSL

  def initialize
    @human = Human.new
    @computer = [R2D2.new, AlphaGo.new, Hal.new, K2SO.new].sample
    @log = History.new
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

  private

  attr_accessor :human, :computer, :log

  def display_welcome_message
    puts "\nWelcome to Rock, Paper, Scissors, Spock, Lizard, " \
         "\e[32m#{human.name}\e[0m!"
    puts "Win \e[32m5\e[0m games to win the match!\n\n"
    puts "Your opponent, \e[32m#{computer.name}\e[0m, greets you:\n"
    puts "\e[34m#{computer.message}\e[0m\n\n"
  end

  def display_goodbye_message
    clear_screen
    puts "\n\e[34mThank you for playing Rock, Paper, Scissors, Spock, " \
         "Lizard.\e[0m\n\n"
    puts "Play session log:"
    display_log
    puts "\nGoodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    log_moves
  end

  def log_moves
    log.moves_log << [human.name, human.move, computer.name, computer.move]
  end

  def display_log
    log.moves_log.each do |sub|
      puts "\e[32m#{sub[0]}\e[0m: #{sub[1]} | \e[32m#{sub[2]}\e[0m: #{sub[3]}"
    end
  end

  def human_won?
    RPSSL_LOGIC[human.move].include?(computer.move)
  end

  def computer_won?
    RPSSL_LOGIC[computer.move].include?(human.move)
  end

  def display_winner
    if human_won? then puts "#{human.name} won!"
    elsif computer_won? then puts "#{computer.name} won!"
    else puts "It's a tie!"; end
  end

  def keep_score
    if human_won? then human.score += 1
    elsif computer_won? then computer.score += 1; end
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
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "I'm sorry, you musy choose y or n."
    end
    answer == 'y'
  end

  def reset_ux
    puts "\n\e[32mResetting all scores to zero...\e[0m"
    sleep 1.25
    puts "\e[32mNew Game Loading...\e[0m"
    sleep 1.25
    puts "\e[32mRandomly selecting your opponent...\e[0m"
    sleep 1.25
  end

  def reset_game
    reset_ux
    @computer = [AlphaGo.new, R2D2.new, AlphaGo.new, Hal.new, K2SO.new].sample
    human.score = 0
    computer.score = 0
    clear_screen
  end

  def play_round
    human.choose
    computer.choose
    display_moves
    display_winner
    keep_score
  end

  def play_continues
    reset_game
    play_match
  end
end

RPSGame.new.play_match
