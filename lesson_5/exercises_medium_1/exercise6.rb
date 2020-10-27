# exercise6.rb - Number Guesser Part 1

# Create an object-oriented number guessing class for numbers in the range 1 to
# 100, with a limit of 7 guesses per game. The game should play like this:

class GuessingGame
  attr_accessor :guess
  attr_reader :secret_number, :guesses

  def initialize
    @guesses = 7
    @secret_number = rand(100)
  end

  def play
    display_welcome
    loop do
      accept_guess
      display_guess_result
      increment_guesses
      break if guess_correct? || guesses == 0
    end
    display_game_result
  end

  private

  def display_welcome
    system 'clear'
    puts "Welcome to NUMBER GUESSER!"
    puts "You get seven chances to guess the secret number between 1 and 100."
    sleep 2.00
    system 'clear'
  end

  def display_game_result
    if guess_correct?
      puts "You Won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def accept_guess
    puts "You have #{guesses} guesses remaining."
    loop do
      print "Enter a number between 1 and 100: "
      self.guess = gets.chomp.to_i

      if !(1..100).include?(guess)
        print "Invalid guess. "
        next
      end
      break
    end
  end

  def display_guess_result
    case guess_result
    when :correct
      puts "That's the number!"
    when :lesser
      puts "Your guess is too low."
    when :greater
      puts "Your guess is too high."
    end
    puts ''
  end

  def guess_result
    if guess == secret_number then :correct
    elsif guess < secret_number then :lesser
    elsif guess > secret_number then :greater
    end
  end

  def increment_guesses
    @guesses -= 1
  end

  def guess_correct?
    guess == secret_number
  end
end

game = GuessingGame.new
game.play

=begin

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

OR:

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!

Note that a game object should start a new game with a new number to guess with each call to #play.

=end