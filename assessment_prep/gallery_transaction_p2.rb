# gallery_transaction_p2.rb

module Displayable; end

class Transaction
  def initialize(client)
    @client = client
  end
end

class Client
  attr_accessor :interests
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Artwork; end

class Painting < Artwork; end

class Photograph < Artwork; end

class Artist; end

john_gray = Client.new('John Gray')
p john_gray.name
p john_gray.interests

sale1 = Transaction.new(john_gray)
p sale1

# describe instance variables and attr_* methods
