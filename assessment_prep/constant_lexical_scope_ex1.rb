# constant_lexical_scope.rb

class Creature
  LEGS = 2
  attr_reader :legs

  def initialize
    @legs = 2
  end

  def how_many_legs
    puts "#{self.class}s walk on #{legs} legs."
  end

  def self.how_many_legs
    puts "#{self}s walk on #{LEGS} legs."
  end
end

class Arachnid < Creature
  LEGS = 8
  attr_reader :legs

  def initialize
    @legs = 8
  end
end

spider = Arachnid.new
spider.how_many_legs
Arachnid.how_many_legs
Creature.how_many_legs
