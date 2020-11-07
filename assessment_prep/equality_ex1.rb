# equality_ex1.rb

class NameTag
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end

bobby = NameTag.new('Robert')
robby = NameTag.new('Robert')

puts bobby == robby
