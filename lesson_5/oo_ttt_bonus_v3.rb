# oo_ttt_bonus_v3.rb

module Displayable
  private

  def clear
    system 'clear'
    system 'cls'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_onboarding_hello
    clear
    puts "\e[34mTic Tac Toe Game Setup..."
    sleep 1.25
    puts "Just a few questions before we begin...\e[0m"
    sleep 1.25
  end

  def display_welcome_message
    puts "\n\e[34mSetting up the board...\e[0m"
    sleep 1.75
    clear
    puts "\e[34mWelcome to Tic Tac Toe!\e[0m"
    puts
  end

  def display_goodbye_message
    puts "\n\e[34mThank you for playing Tic Tac Toe. Goodbye!\e[0m"
  end

  def display_scoreboard
    puts "\e[34mMatch Score\e[0m"
    puts "\e[32m#{human.name}:\e[0m #{human.score} | " \
         "\e[32m#{computer.name}:\e[0m #{computer.score}"
    puts
  end

  def display_board
    puts "You are #{human.marker}. Computer is #{computer.marker}."
    puts "Win #{TTTGame::MATCH_GAMES} games to win the match!"
    puts
    display_scoreboard
    board.draw
    puts
  end

  def display_match_winner
    if human.score == TTTGame::MATCH_GAMES
      puts "#{human.name} wins the match!"
    else
      puts "#{computer.name} wins the match!"
    end
    puts
  end

  def display_play_again_message
    puts "\e[34mThe match continues! Let's play again!\e[0m"
    puts
  end

  def display_result(result)
    clear_screen_and_display_board

    case result
    when :human
      puts "\e[32m#{human.name} won!\e[0m"
    when :computer
      puts "\e[32m#{computer.name} won!\e[0m"
    else
      puts "\e[32mIt's a tie!\e[0m"
    end
    sleep 2.00
  end
end

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

  def [](num)
    @squares[num].marker
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
  attr_accessor :name, :score, :marker

  def initialize
    @marker = marker
    @name = name
    @score = 0
  end
end

class Human < Player
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

  def choose_marker
    m = ''
    loop do
      puts "\nChoose your marker: (X or O)"
      m = gets.chomp.upcase
      break if %w(X O).include?(m)
      puts "Invalid entry. Please enter X or O only."
    end
    self.marker = m
  end
end

class Computer < Player
  def set_name
    self.name = %w(AlphaGo Hal9000 R2D2 Watson).sample
  end

  def choose_marker(other_marker)
    self.marker = (other_marker == 'X' ? 'O' : 'X')
  end

  def center_move(board)
    5 if board.unmarked_keys.include?(5)
  end

  def defensive_move(board)
    Board::WINNING_LINES.each do |line|
      if line.count { |num| board[num] == opponent_marker } == 2 &&
         line.count { |num| board[num] == ' ' } == 1
        return line.select { |num| board[num] == ' ' }.first
      end
    end
    nil
  end

  def offensive_move(board)
    Board::WINNING_LINES.each do |line|
      if line.count { |num| board[num] == marker } == 2 &&
         line.count { |num| board[num] == ' ' } == 1
        return line.select { |num| board[num] == ' ' }.first
      end
    end
    nil
  end

  private

  def opponent_marker
    marker == 'X' ? 'O' : 'X'
  end
end

class TTTGame
  include Displayable

  FIRST_TO_MOVE = 'X'
  MATCH_GAMES = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = FIRST_TO_MOVE
  end

  def play
    display_onboarding_hello
    assign_player_names
    assign_player_markers
    loop do
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
      reset_board
      display_play_again_message
    end
  end

  def assign_player_names
    human.set_name
    computer.set_name
  end

  def assign_player_markers
    human.choose_marker
    computer.choose_marker(human.marker)
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
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

  def valid_square_choice?(square)
    square.to_i.to_s == square && board.unmarked_keys.include?(square.to_i)
  end

  def human_moves
    square = nil
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    loop do
      square = gets.chomp
      break if valid_square_choice?(square)
      puts "I'm sorry, that is not a valid choice."
    end

    board.[]=(square.to_i, human.marker)
  end

  def computer_moves
    mark = computer.offensive_move(board) || computer.defensive_move(board) ||
           computer.center_move(board) || board.unmarked_keys.sample

    board.[]=(mark, computer.marker)
  end

  def determine_game_result
    case board.winning_marker
    when human.marker
      increment_score(:human)
      display_result(:human)
    when computer.marker
      increment_score(:computer)
      display_result(:computer)
    else
      display_result(:tie)
    end
  end

  def increment_score(winner)
    case winner
    when :human
      human.score += 1
    when :computer
      computer.score += 1
    end
  end

  def match_win?
    human.score == MATCH_GAMES || computer.score == MATCH_GAMES
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

  def reset_board
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def play_continues
    reset_board
    reset_score
  end
end

TTTGame.new.play
