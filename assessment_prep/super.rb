# super.rb

class Person
  attr_reader :name, :age, :birthplace

  def initialize(name, age, birthplace)
    @name = name
    @age = age
    @birthplace = birthplace
  end
end

class Doctor < Person
  attr_reader :salutation

  def initialize(name, age, birthplace, salutation)
    super(name, age, birthplace)
    @salutation = salutation
  end

  def to_s
    "#{salutation} #{name} is #{age} years old and was born in #{birthplace}."
  end
end

bob = Doctor.new("Robert Gray", 50, "Wheeling, WV", "Dr.")
puts bob
