# who_has_the_most_money.rb
# 6 kyu

# You're going on a trip with some students and it's up to you to keep track of
# how much money each Student has. A student is defined like this:

class Student
  attr_reader :name
  attr_reader :fives
  attr_reader :tens
  attr_reader :twenties

  def initialize(name, fives, tens, twenties)
    @name = name
    @fives = fives
    @tens = tens
    @twenties = twenties
  end
end

=begin

As you can tell, each Student has some fives, tens, and twenties. Your job is
to return the name of the student with the most money. If every student has the
same amount, then return "all".

Notes:

Each student will have a unique name.

There will always be a clear winner: either one person has the most, or
everyone has the same amount.

If there is only one student, then that student has the most money.

=end

def most_money(students)
  # NOTE: the Student class is preloaded
end

phil = Student.new("Phil", 2, 2, 1)
cam = Student.new("Cameron", 2, 2, 0)
geoff = Student.new("Geoff", 0, 3, 0)

p most_money([cam, geoff, phil]) == "Phil"
p most_money([cam, geoff]) == "all"
p most_money([geoff]) == "Geoff"

=begin

<-PEDAC->
problem:
  - accessing the objects in the Student class, return the object with the most
    money
  - return "all" if everyone has the same amount of money

input: array of Student objects
output: string
data structure: class, array, integer 

algorithm:
  - 

=end
