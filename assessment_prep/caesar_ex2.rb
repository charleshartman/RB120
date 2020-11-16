# caesar_ex2.rb

require "io/console"

module PlusThirteen
  CIPHER_LOWER = ('a'..'z').to_a + ('a'..'n').to_a
  CIPHER_UPPER = ('A'..'Z').to_a + ('A'..'N').to_a

  def plus13(char)
    case char
    when 'a'..'z' then CIPHER_LOWER[CIPHER_LOWER.find_index(char) + 13]
    when 'A'..'Z' then CIPHER_UPPER[CIPHER_UPPER.find_index(char) + 13]
    else char
    end
  end
end

module Displayable
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

  def continue_prompt
    print "\e[34m[Press any key to continue]\e[0m"
    STDIN.getch
    print "                            \r"
  end
end

class Caesar
  include PlusThirteen
  include Displayable

  def cipher
    loop do
      clear_screen
      @code = ''
      query_string
      rot13
      display_result
      break unless cipher_again?
    end
    display_goodbye
  end

  private

  def rot13
    message.each_char { |char| code << plus13(char) }
  end

  def <<(char)
    code << char
  end

  def query_string
    loop do
      prompt_purple("\nPlease enter the message you wish to cipher:")
      self.message = gets.chomp
      break unless message.delete(' ').empty?
      puts "I'm sorry, you must enter a value."
    end
  end

  def display_result
    clear_screen
    prompt_purple("\nResult:")
    prompt_green("origin: #{message}")
    prompt_green("rot13:  #{code}\n")
    continue_prompt
    clear_screen
  end

  def cipher_again?
    answer = nil
    loop do
      prompt_purple("\nWould you like to cipher another message? (y/n)")
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Invalid entry. Please enter y or n only."
    end

    answer == 'y'
  end

  def display_goodbye
    prompt_purple("Happy (secret) coding! Farewell!")
  end

  attr_accessor :code, :message
end

Caesar.new.cipher
