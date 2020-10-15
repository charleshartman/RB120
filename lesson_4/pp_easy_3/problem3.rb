# problem3.rb - Question 3

# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class,
# both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

lulu = AngryCat.new(5, 'Lulu')
mabel = AngryCat.new(3, 'Mabel')

mabel.hiss
lulu.hiss
