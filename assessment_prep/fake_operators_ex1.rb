# fake_operators_ex1.rb

class NameTag
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def +(other)
    age + other.age
  end
end

lulu = NameTag.new('Lulu', 29)
lizzie = NameTag.new('Elizabeth', 71)

puts lulu + lizzie
