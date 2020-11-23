# baggu.rb

module Carryable
  def handle
    puts 'This bag has a handle.'
  end
end

class Container
  def ancestors
    self.class.ancestors
  end
end

class Bag < Container
  include Carryable

  def initialize(color, material)
    @color = color
    @material = material
  end
end

baggu = Bag.new('white', 'linen')
p baggu
p Bag.ancestors
p baggu.ancestors
