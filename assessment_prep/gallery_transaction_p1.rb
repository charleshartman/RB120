# gallery_transaction_p1.rb

module Displayable; end

class Transaction
  def initialize
    @client = client
  end
end

class Client; end

class Artwork; end

class Painting < Artwork; end

class Photograph < Artwork; end

class Artist; end

sale1 = Transaction.new('John Gray')
p sale1

# describe classes and objects generally, as well as the creation of objects
