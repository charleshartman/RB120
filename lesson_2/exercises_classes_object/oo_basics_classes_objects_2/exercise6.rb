# exercise6.rb - Colorful Cat

# Using the following code, create a class named Cat that prints a greeting
# when #greet is invoked. The greeting should include the name and color of
# the cat. Use a constant to define the color.

class Cat
  CAT_COLOR = 'black'

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I am a #{CAT_COLOR} cat."
  end
end

kitty = Cat.new('Sophie')
kitty.greet