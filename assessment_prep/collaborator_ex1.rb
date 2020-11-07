# collaborator.rb

class Transaction
  def initialize(client)
    @client = client
  end
end

class Client
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

john_grey = Client.new('John Grey')
satya_james = Client.new('Satya James')

sale1 = Transaction.new(john_grey)
sale2 = Transaction.new(satya_james)
p sale1
p sale2
