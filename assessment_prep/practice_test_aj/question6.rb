# question6.rb

# In the code below, what path does Ruby take to resolve the grow method call
# on the last line?

module Growable; end
module Photosynthesizable; end
module Reproducable; end

class Plant
  def grow
    # implementation
  end
end

class Tree < Plant
  include Growable
end

class Salicaceae < Tree
  include Reproducable
  include Photosynthesizable
end

my_tree = Salicaceae.new
my_tree.grow

puts Salicaceae.ancestors

# The method lookup path for my_tree.grow would be:

# Salicaceae -> Photosynthesizable -> Reproducable -> Tree -> Growable ->
# Plant -> Object -> Kernel -> BasicObject

# This can be checked with by calling `Module#ancestors` on the `Salicaceae`
# class, as we have above.
