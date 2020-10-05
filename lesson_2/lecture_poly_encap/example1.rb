# example1.rb

class Animal
  def eat
    puts "animal eating"
  end
end

class Fish < Animal
  def eat
    puts "fish eating"
  end
end

class Cat < Animal
  def eat
     puts "cat eating"
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Cat.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end