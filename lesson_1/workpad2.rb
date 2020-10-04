# workpad2.rb

=begin

class Being

   def initialize
       puts "Being created"
   end
end


b1 = Being.new
b2 = Being.allocate
puts b1
puts b2



class Person
  attr_writer :first_name, :last_name

  def full_name
    @first_name + ' ' + @last_name
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
p mike.full_name

=end

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end

  def change_grade(new_grade)
    @grade = new_grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade # => "A"

class MeMyselfAndI
  p self

  def self.me
    p self
  end

  def myself
    p self
  end
end

i = MeMyselfAndI.new
i.myself
p MeMyselfAndI.me

