# problem2.rb - Question 2

# In the last question we had the following classes:

class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

# either make hi and greet class methods or instantiate a new Hello object and
# invoke `hi` on it.

Hello.hi
