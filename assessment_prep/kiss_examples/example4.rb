# example4.rb
# Polymorphism
# Interface Inheritance

module Swimmable
  def swim
    puts 'Yep, I can swim, no problem.'
  end
end

class Creature
  def move
    puts 'I can move.'
  end
end

class Turtle < Creature
  include Swimmable

  def move
    puts 'I move slowly...'
  end
end

class Hare < Creature
  include Swimmable

  def move
    puts 'I move quickly!'
  end
end

class Rhino < Creature; end
