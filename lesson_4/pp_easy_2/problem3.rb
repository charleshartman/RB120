# problem3.rb - Question 3

# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "Tastes like #{flavor}."
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# you can call Object#ancestors on the class to see the method lookup chain.
# in this case the calls will look first in the object class, then in the
# `Taate` module, then in Object and so on.

p Orange.ancestors # => [Orange, Taste, Object, Kernel, BasicObject]

# note: Object#ancestors is a class method and it will not work if you call this
# method on an instance of a class (unless of course that instance has a method
# called ancestors).
