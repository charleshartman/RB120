# class_method_ex1.rb

class Client
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.greeting
    puts "Greetings, #{self}! This is a class method."
  end

  def greet
    puts "Hola, #{name}! This is an instance method."
  end
end

tom = Client.new('Tom')
tom.greet
Client.greeting
