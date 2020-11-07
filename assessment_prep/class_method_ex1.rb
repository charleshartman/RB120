# class_method_ex1.rb

class Client
  def self.greeting
    puts "Greetings, Client! This is a class method."
  end

  def greet
    puts "Hola, client! This is an instance method."
  end
end

tom = Client.new
tom.greet
Client.greeting
