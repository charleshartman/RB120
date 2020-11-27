# rpgplayer.rb

module Armorable
  def attach_armor
    # implementation omitted
  end

  def remove_armor
    # implementation omitted
  end
end

module Spellable
  def cast_spell(spell)
    # implementation omitted
  end
end

class RPGPlayer
  attr_reader :str, :int, :name, :cls
  attr_accessor :health

  def initialize(name)
    @name = name
    @health = 100
    @str = roll_dice
    @int = roll_dice
  end

  def heal(num)
    self.health += num
  end

  def hurt(num)
    self.health -= num
  end

  def to_s
    "Name: #{name}\nClass: #{cls}\nHealth: #{health}\nStrength: #{str}\n" \
    "Intelligence: #{int}\n"
  end

  private

  def roll_dice
    (2..12).to_a.sample
  end
end

class Warrior < RPGPlayer
  include Armorable

  def initialize(name)
    super
    @cls = 'Warrior'
    @str += 2
  end
end

class Magician < RPGPlayer
  include Spellable

  def initialize(name)
    super
    @cls = 'Magician'
    @int += 2
  end
end

class Paladin < RPGPlayer
  include Spellable
  include Armorable

  def initialize(name)
    super
    @cls = 'Paladin'
  end
end

class Bard < RPGPlayer
  include Spellable

  def initialize(name)
    super
    @cls = 'Bard'
  end

  def create_potion
    # implementation omitted
  end
end

charles = Paladin.new('Charles')
puts charles
