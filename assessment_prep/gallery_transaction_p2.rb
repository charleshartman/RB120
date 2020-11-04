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

john_grey = Client.new('John Grey')
p john_grey.name
p john_grey.interests

sale1 = Transaction.new(john_grey)
p sale1

# describe instance variables and attr_* methods

=begin

In this example we define the `Client` class on `lines 11-18`. We define the
`initialize` method on `lines 15-17`. It takes one argument, which is assigns to
the `@name` instance variable. Additionally, we invoke the attr_accessor method
to define setter and getter methods for instance variable @interests and we
invoke the attr_reader method to define a getter method for instance variable
`@name`.

Instance variables (and the values they point to) such as these are how objects
keep track of state.

=end
