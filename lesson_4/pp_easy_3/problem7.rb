# problem7.rb - Question 7

# What is used in this class but doesn't add any value?

class Light
  # attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super " \
    "high and a color of green."
  end
end

# return on line 14 is redundant (I removed).
# attr_accessors are not needed.
