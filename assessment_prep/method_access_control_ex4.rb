# method_access_control_ex4.rb

class Greeting
  def hello
    "Greetings, " + padlocked
  end

  private

  def padlocked
    "Earthling!"
  end
end

alien = Greeting.new
puts alien.hello     # this works
puts alien.padlocked # But not this => private/NoMethodError
