# problem8.rb - Question 8

# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# You can see in the make_one_year_older method we have used self. What does
# self refer to here?

# self refers to the calling object, so:

lulu = Cat.new('Siamese')
lulu.make_one_year_older
puts lulu.age
lulu.make_one_year_older
puts lulu.age

# increases the calling object's age by 1 each time `make_one_year_older` is
# invoked by the particular object (in this case `lulu`).
