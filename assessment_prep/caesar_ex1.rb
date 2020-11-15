# caesar_ex1.rb

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

class Caesar
  include PlusThirteen

  def initialize(message)
    @message = message
    @code = ''
  end

  def rot13
    message.each_char { |char| code << plus13(char) }
    code
  end

  private

  def <<(char)
    code << char
  end

  attr_accessor :code
  attr_reader :message
end

puts Caesar.new('meet twelve noon, corner eighth and davis, gray cap').rot13
