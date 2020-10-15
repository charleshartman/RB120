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
