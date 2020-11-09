# question3.rb

# The below code doesn't run quite as expected. What's wrong with it, and what
# does this tell us about class variables and class inheritance? Include in your
# answer the code you would use to produce the anticipated result.

class House
  @@number_of_houses = 0

  def initialize
    @@number_of_houses += 1
  end

  def self.number
    @@number_of_houses
  end
end

class Room < House
  def initialize; end # <== change made here
end

my_house = House.new
p my_house
puts "Number of houses: #{House.number}"

living_room = Room.new
p living_room
puts "Number of houses: #{House.number}"
