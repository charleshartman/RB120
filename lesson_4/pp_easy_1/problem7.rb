# problem7.rb - Question 7

# What is the default return value of to_s when invoked on an object? Where
# could you go to find out if you want to be sure?

# The default return value of to_s when invoked on an object is a string
# with the object's class followed by an alphanumberic string representing an
# encoding of the object_id.

class Dog
  attr_reader :name, :breed

  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def to_s
    "My #{breed}'s name is #{name}."
  end
end

muffy = Dog.new('Muffy', "Chihuahua")
puts muffy # without custom to_s defined -> #<Dog:0x00007fd13a033ca8>
puts muffy.name # -> Muffy

