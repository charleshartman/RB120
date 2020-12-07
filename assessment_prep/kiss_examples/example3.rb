# example3.rb
# Polymorphism
# Class Inheritance

class Creature
  def move
    puts 'I can move.'
  end
end

class Turtle < Creature
  def move
    puts 'I move slowly...'
  end
end

class Hare < Creature
  def move
    puts 'I move quickly!'
  end
end
