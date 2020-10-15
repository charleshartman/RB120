# problem7.rb - Question 7

# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would
# you need to write to test your theory?

# @@cats.count is a class variable, in this case it is initialized to 0 and
# incremented by + 1 every time a new object of the Cat class is instantiated.
# To test, with merely need to instantiate a few objects of the class Cat and
# then call cats.count on the Cat class:

Cat.new('Siamese')
Cat.new('Tabby')
p Cat.cats_count
