# gallery_transaction_p1.rb

module Displayable; end

class Transaction
  def initialize(client)
    @client = client
  end
end

class Client; end

class Artwork; end

class Painting < Artwork; end

class Photograph < Artwork; end

class Artist; end

sale1 = Transaction.new('John Grey')
p sale1

# describe classes and objects generally, as well as the creation of objects

=begin

In this beginning outline of our program, we have defined a number of classes
as well as a module for future use. On `line 5` we define a `Transaction`
class with one method. This `#initialize` method on `lines 6-9` initializes a
new `Transaction` object and assigns the instance variable `@client` to the
value passed in as an argument. In the example above, we pass in a string, but
as the development of this program progresses this will likely be a local
variable that references a `Client` object.

=end
