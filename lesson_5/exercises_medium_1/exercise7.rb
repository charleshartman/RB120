# exercise7.rb - Number Guesser Part 2

# In the previous exercise, you wrote a number guessing game that determines a
# secret number between 1 and 100, and gives the user 7 opportunities to guess
# the number.

# Update your solution to accept a low and high value when you create a
# GuessingGame object, and use those values to compute a secret number for the
# game. You should also change the number of guesses allowed so the user can
# always win if she uses a good strategy. You can compute the number of guesses
# with:
# Math.log2(size_of_range).to_i + 1

class GuessingGame
  attr_accessor :guess, :guesses
  attr_reader :secret_number, :lower, :higher, :range

  def initialize(lower, higher)
    @lower = lower
    @higher = higher
    @range = lower..higher
    @secret_number = rand(lower..higher)
    @guesses = Math.log2(higher - lower).to_i + 1
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
    puts "Your number of chances is based on the size of the range."
    puts "Good Luck!"
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
    puts "You have #{@guesses} guesses remaining."
    loop do
      print "Enter a number between #{lower} and #{higher}: "
      self.guess = gets.chomp.to_i

      if !(range).include?(guess)
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

game = GuessingGame.new(501, 1500)
# p game.secret_number
# p game.range
# p game.guesses
game.play

=begin

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
That's the number!

You won!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low.

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low.

You have no more guesses. You lost!

=end

# Note that a game object should start a new game with a new number to guess
# with each call to #play.
