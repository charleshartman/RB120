
# Fix the Program - Mailable

Correct the following program so it will work properly. Assume that the Customer and Employee classes have complete implementations; just make the smallest possible change to ensure that objects of both types have access to the print_address method.

```ruby
module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
```

To work properly, the `betty` and `bob` objects need to be able to call the `print_address` method. This method is defined in the `Mailable` module, which is currently not 'mixed in' to the classes these objects have been instantiated from. The fix is simply to use the `include` method invocation in each class to mix the module in. `Customer` and `Employee` classes will then inherit from the `Mailable` module and the `#print_address` method will become part of public interface of the `bob` and `betty` objects. After searching the respective object's class, `Mailable` will be next on the object's method lookup path.
