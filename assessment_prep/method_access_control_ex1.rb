# method_access_control_ex1.rb

class AddSeven
  SEVEN = 7

  def initialize(number)
    @number = number
    puts calculation
  end

  private

  def calculation
    @number + SEVEN
  end
end

AddSeven.new(14)
