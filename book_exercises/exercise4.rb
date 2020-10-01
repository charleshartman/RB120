# exercise4.rb

# 1. Create a superclass called Vehicle for your MyCar class to inherit from and
#    move the behavior that isn't specific to the MyCar class to the superclass.

# 2. Create a constant in your MyCar class that stores information about the
#    vehicle that makes it different from other types of Vehicles.

# 3. Then create a new class called MyTruck that inherits from your superclass
#    that also has a constant defined that separates it from the MyCar class
#    in some way.

# 4. Add a class variable to your superclass that can keep track of the number
#    of objects created that inherit from the superclass. Create a method to 
#    print out the value of this class variable as well.

# 5. Create a module that you can mix in to ONE of your subclasses that 
#    describes a behavior unique to that subclass.

# 6. Print to the screen your method lookup for the classes that you have
#    created.

# 7. Move all of the methods from the MyCar class that also pertain to the
#    MyTruck class into the Vehicle class. Make sure that all of your previous
#    method calls are working when you are finished.

# 8. Write a method called age that calls a private method to calculate the age
#    of the vehicle. Make sure the private method is not available from outside
#    of the class. You'll need to use Ruby's built-in Time class to help.

module Blingable
  def has_dice?
    dice ? 'Fuzzy dice hanging from the rear-view.' : 'No dice!'
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle

  attr_accessor :color
  attr_reader :year, :model

  @@total_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@total_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push down on the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_off
    @current_speed = 0
    puts 'Turning off the car.'
  end

  def spray_paint(color)
    self.color = color
    puts "You paint your vehicle #{color}."
  end

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gasoline"
  end

  def self.vehicle_inventory
    puts "#{@@total_vehicles} object(s) using the 'Vehicle' superclass."
  end

  def age
    puts "Your vehicle is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  attr_accessor :dice

  include Blingable  
  
  NUMBER_OF_DOORS = 4

  def initialize(year, model, color, dice)
    super(year, model, color)
    @dice = dice
  end

 def to_s
    "Your car is a #{color} #{year} #{model}."
  end

end

class MyTruck < Vehicle

  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "Your truck is a #{color} #{year} #{model}."
  end

end

pinto = MyCar.new(1976, 'Ford Pinto', 'yellow', true)
puts pinto
escort = MyCar.new(1982, 'Ford Escort', 'silver', false)
toy = MyTruck.new(1984, 'Toyota Tacoma', 'blue')
puts toy
toy.age
puts toy.can_tow?(1500)

puts "-------------------------"

pinto.speed_up(20)
pinto.current_speed
pinto.speed_up(20)
pinto.current_speed
pinto.brake(20)
pinto.current_speed
pinto.brake(20)
pinto.current_speed
pinto.shut_off
pinto.current_speed

puts "-------------------------"

pinto.spray_paint('pink')

puts "-------------------------"

MyCar.gas_mileage(245, 10)
Vehicle.vehicle_inventory
puts "-------------------------"

puts "---MyCar method lookup---"
puts MyCar.ancestors
puts "-------------------------"
puts "--MyTruck method lookup--"
puts MyTruck.ancestors
puts "-------------------------"
puts "--Vehicle method lookup--"
puts Vehicle.ancestors
puts "-------------------------"

puts pinto.has_dice?
puts escort.has_dice?
