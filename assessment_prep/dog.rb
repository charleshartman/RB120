# dog.rb

require 'pp'

class Dog
  def bark
    bark_now
  end

  private

  def bark_now
    puts "Bark!"
  end
end

lulu = Dog.new
pp(lulu)
p lulu
lulu.bark
