# method_access_control_ex1.rb

class AddSeven
  SEVEN = 7

  def initialize(number)
    @number = number
  end

  def add_seven
    puts calculation
  end

  private

  def calculation
    @number + SEVEN
  end
end

number = AddSeven.new(14)
number.add_seven # => 21
