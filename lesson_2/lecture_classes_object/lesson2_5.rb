# lesson2_5.rb

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    name_processor(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(n)
    name_processor(n)
  end

  def to_s
    name
  end

  private

  def name_processor(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end

end

# Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
puts "The person's name is: #{bob.name}" # => The person's name is: Robert Smith
