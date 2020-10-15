# problem5.rb - Question 5

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer # => NoMethodError exception, this is a class method
tv.model # => this is fine, instance method

Television.manufacturer # => this works, class calling class method
Television.model # => NoMethodError exception, this is an instance method
