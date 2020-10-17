# oo_ttt_spike.rb

require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :name, :score

  def initialize(marker)
    @marker = marker
    @name = name
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    loop do
      clear
      assign_player_names
      display_welcome_message
      main_game
      display_match_winner
      play_again? ? play_continues : break
    end

    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      determine_game_result
      break if match_win?
      reset
      display_play_again_message
    end
  end

  def clear
    system 'clear'
    system 'cls'
  end

  def assign_player_names
    n = ""
    loop do
      puts "\nPlease enter your name:"
      n = gets.chomp
      break unless n.delete(' ').empty?
      puts "I'm sorry, you must enter a value."
    end
    human.name = n.squeeze(' ')
    computer.name = %w(AlphaGo Hal9000 R2D2 Watson).sample
    clear
  end

  def display_welcome_message
    puts "\e[34mWelcome to Tic Tac Toe!\e[0m"
    puts
  end

  def display_goodbye_message
    puts 'Thank you for playing Tic Tac Toe. Goodbye!'
  end

  def display_board
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts "Win five games to win the match!"
    puts
    display_scoreboard
    board.draw
    puts
  end

  def display_scoreboard
    puts "\e[34mMatch Score\e[0m"
    puts "\e[32m#{human.name}:\e[0m #{human.score} | " \
         "\e[32m#{computer.name}:\e[0m #{computer.score}"
    puts
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def joinor(keys)
    return keys.first.to_s if keys.size == 1
    (keys[0..-2].join(', ')) + ' or ' + keys.last.to_s
  end

  def human_moves
    square = nil
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "I'm sorry, that is not a valid choice."
    end

    board.[]=(square, human.marker)
  end

  def computer_moves
    board.[]=(board.unmarked_keys.sample, computer.marker)
  end

  def display_result(result)
    clear_screen_and_display_board

    case result
    when 'human'
      puts "\e[32m#{human.name} won!\e[0m"
    when 'computer'
      puts "\e[32m#{computer.name} won!\e[0m"
    else
      puts "\e[32mIt's a tie!\e[0m"
    end
    sleep 1.75
  end

  def determine_game_result
    case board.winning_marker
    when human.marker
      human.score += 1
      display_result('human')
    when computer.marker
      computer.score += 1
      display_result('computer')
    else
      display_result('tie')
    end
  end

  def match_win?
    human.score == 5 || computer.score == 5
  end

  def display_match_winner
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
      puts "\nGame Over! Start a new match? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Invalid entry. Please enter y or n only."
    end

    answer == 'y'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "\e[34mThe match continues! Let's play again!\e[0m"
    puts
  end

  def play_continues
    game = TTTGame.new
    game.play
  end
end

game = TTTGame.new
game.play
