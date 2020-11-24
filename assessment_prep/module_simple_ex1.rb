# module_simple_ex1.rb

module Portable
  def carry
    "You can transport this by hand."
  end
end

class Container; end

class Crate < Container; end

class Bag < Container
  include Portable

  attr_reader :type, :color

  def initialize(type, color)
    @type = type
    @color = color
  end
end

baggu = Bag.new('nylon', 'blue')
puts baggu.carry
