# question1.rb

class Humanoid
  EYES = 2
  attr_reader :eyes

  def initialize
    @eyes = 2
  end

  def number_of_eyes
    puts "Members of the #{self.class} class have #{eyes} eyes."
  end

  def self.number_of_eyes
    # fixed with explicit `self::EYES`
    puts "Members of the #{self} class have #{self::EYES} eyes."
  end
end

class Cyclops < Humanoid
  EYES = 1
  attr_reader :eyes

  def initialize
    @eyes = 1
  end
end

cyclops = Cyclops.new
cyclops.number_of_eyes
Cyclops.number_of_eyes
Humanoid.number_of_eyes

