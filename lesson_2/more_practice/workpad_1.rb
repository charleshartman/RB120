# workpad_1.rb

=begin

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name = '')
    @first_name = first_name
    @last_name = last_name
  end

  def name
    return "#{first_name} #{last_name}" unless last_name == ''
    "#{first_name}"
  end

  def name=(name)
    if name.split.size > 1
      self.first_name = name.split[0]
      self.last_name = name.split[1]
    else
      self.first_name = name
      self.last_name = ''
    end
  end

end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

puts "The person's name is: #{bob}"
