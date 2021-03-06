# problem4.rb - Question 4

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single instance method called greet that
# takes a string argument and prints that argument to the terminal.

class Greeting
  def greet(str)
    puts str
  end
end

# Now create two other classes that are derived from Greeting: one called Hello
# and one called Goodbye. The Hello class should have a hi method that takes no
# arguments and prints "Hello". The Goodbye class should have a bye method to
# say "Goodbye". Make use of the Greeting class greet method when implementing
# the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye
# classes.

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

cheer = Greeting.new
cheer.greet("Hooray!")

enter = Hello.new
enter.hi
leave = Goodbye.new
leave.bye
