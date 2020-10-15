# problem5.rb - Question 5

# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    # name = name   <- local variable assignment (wrong)
    @name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# the `Pizza` class initializes the instance variable `@name` upon instantiation
# of a new instance/object, instance variables start with `@`... the `Fruit`
# class only has a local variable.

# fixed by adding `@` to Fruit initialization

# also book notes:
pepperoni = Pizza.new('Pepperoni Pizza')
p pepperoni.instance_variables
