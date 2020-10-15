# problem4.rb - Question 4

# What could you add to this class to simplify it and remove two methods from
# the class definition while still maintaining the same functionality?

Copy Code
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    # puts "I am a #{@type} of Bees Wax"
    puts "I am a #{type} of Bees Wax"
  end
end

# add attr_accessor for `type`
# also, change the `describe_type` method to call the `type` getter method
# instead of accessing the instance variable directly.
