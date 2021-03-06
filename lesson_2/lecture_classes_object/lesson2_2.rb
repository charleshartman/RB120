# lesson2_2.rb

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name='')
    self.first_name = first_name
    self.last_name = last_name
  end

  def name
    (first_name + ' ' + last_name).strip
  end

end

# Modify the class definition from above to facilitate the following methods.
# Note that there is no name= setter method now.

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

# Hint: let first_name and last_name be "states" and create an instance method
# called name that uses those states.