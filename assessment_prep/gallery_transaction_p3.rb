# gallery_transaction_p3.rb

module Displayable; end

class Transaction
  @@order_number = 0

  def initialize(client)
    @@order_number += 1
    @client = client
  end

  def self.total_transactions
    @@order_number
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
satya_james = Client.new('Satya James')
p john_gray.name
p john_gray.interests

sale1 = Transaction.new(john_gray)
sale2 = Transaction.new(satya_james)
p sale1
p sale2

puts Transaction.total_transactions

# describe class methods and class variables
