# simple_self.rb

class Cat
  # attr_accessor :name

  def hello
    self
  end

  def self.hello
    self
  end
end

lulu = Cat.new
# lulu.name = "Lulu"

p lulu.hello
p Cat.hello
