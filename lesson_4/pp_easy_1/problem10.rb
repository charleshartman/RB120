# problem10.rb - Question 10

# If we have the class below, what would you need to call to create a new
# instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

Bag.new('brown', 'paper')

# as above, simply call `new` on the class and supply two arguments.
