# constant_lexical_scope_ex2.rb

class Creature
  LEGS = 2

  def how_many_legs
    puts "#{self.class}s walk on #{self.class::LEGS} legs."
  end
end

class Arachnid < Creature
  LEGS = 8
end

spider = Arachnid.new
spider.how_many_legs # => Arachnids walk on 2 legs.
zombie = Creature.new
zombie.how_many_legs # => Creatures walk on 2 legs.
