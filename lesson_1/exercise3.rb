# exercise3.rb

# When running the following code...

class Person
  # attr_reader :name
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

  def change_name(name)
    self.name = name
    puts "Name changed to #{name}."
  end

end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name
bob.change_name("Not Bob")

# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how do we fix it?

# attr was set to reader rather than accessor (or writer), so name could only
# be read, not written to