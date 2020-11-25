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

puts bobby == robby # => true
puts bobby # => #<NameTag:0x00007f9f558401b0> (encoding of object id may differ)
puts robby # => #<NameTag:0x00007f9f55840138> (encoding of object id may differ)
