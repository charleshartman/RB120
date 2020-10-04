# exercise2.rb

class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gasoline"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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
    puts "You paint your car #{color}."
  end

  def to_s
    "You're driving a #{color} #{year} #{model}."
  end
end

pinto = MyCar.new(1976, 'Ford Pinto', 'blue')
puts pinto
pinto.speed_up(20)
pinto.current_speed
pinto.speed_up(20)
pinto.current_speed
pinto.brake(20)
# pinto.current_speed
# pinto.brake(20)
# pinto.current_speed
# pinto.shut_off
# pinto.current_speed
# pinto.spray_paint('pink')
MyCar.gas_mileage(245, 10)
puts MyCar.ancestors

