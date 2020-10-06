# exercise4.rb - Reverse Engineering

# Write a class that will display:

# ABC
# xyz
# when the following code is run:

class Transform
  def initialize(str)
    @str = str
  end

  def uppercase             # <== instance method
    @str.upcase
  end

  def self.lowercase(str)   # <== class method
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
