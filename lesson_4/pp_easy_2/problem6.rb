# problem6.rb - Question 6

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
    puts 'this one is a class method'
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How
# would you call a class method?

# manufacturer is a class method, class methods start with self (the class),
# they are called by the class it(self), for example:

Television.manufacturer
