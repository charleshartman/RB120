# method_access_control_ex2.rb

class Greeting
  def hello
    "You may call " + padlocked
  end

  protected

  def padlocked
    "this method from all instances of #{self.class}."
  end
end

puts Greeting.new.hello     # this works
puts Greeting.new.padlocked # But not this => protected/NoMethodError
