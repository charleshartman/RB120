# self_ex1.rb

class NameTag
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_age(new_age)
    self.age = new_age
  end

  def self.info
    puts "This is a class method, called by the #{self} class."
  end

  private

  attr_writer :age
end

lulu = NameTag.new('Lulu', 29)
puts lulu.age
lulu.change_age(30)
puts lulu.age

NameTag.info
