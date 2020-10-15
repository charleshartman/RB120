# problem6.rb - Question 6

# What could we add to the class below to access the instance variable @volume?

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end

  # def volume
  #   @volume
  # end
end

# we need to add getter and setter methods depending on if we need public
# read or write access (or both). This can be done by defining the methods
# "by hand" or be use of attr_reader, attr_writer, attr_accessor.

=begin
note book:
Technically we don't need to add anything at all. We are able to access instance
variables directly from the object by calling instance_variable_get on the
instance. This would return something like this:

big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")
=> 5000
While this works it is generally not a good idea to access instance variables
in this way. Instead we can add a method to this object that returns the
instance variable.
=end

cube = Cube.new(2000)
puts cube.volume
puts cube
