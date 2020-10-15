# problem10.rb - Question 10

# What are the benefits of using Object Oriented Programming in Ruby? Think
# of as many as you can.

class Benefits
  def list_ruby_oop_benefits
    puts "\nDRY - Don't Repeat Yourself!\n\n"
    puts "Polymorphism - many forms - allows various data types to use common" \
         " behaviors.\n\n"
    puts "Protects data by simplifying and limiting public methods.\n\n"
    puts "OOP: A way to section off areas of code that performed certain" \
         " procedures so that their programs could become the interaction" \
         " of many small parts, as opposed to one massive blob of dependency."
    puts "\nInheritance\n\n"
    puts "Encapsulation\n\n"
  end
end

puts Benefits.new.list_ruby_oop_benefits

=begin

Because there are so many benefits to using OOP we will just summarize some
of the major ones:

1. Creating objects allows programmers to think more abstractly about the code
   they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that need it,
   meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an
   application without duplication.
5. We can build applications faster as we can reuse pre-written code.
6. As the software becomes more complex this complexity can be more easily
   managed.

=end
