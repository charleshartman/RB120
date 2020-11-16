
# Reverse Engineering

Write a class that will display the expect output:

```ruby
class Transform
  attr_reader :str

  def initialize(str)
    @str = str
  end

  def uppercase
    str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

# when the following code is run:
my_data = Transform.new('abc')
puts my_data.uppercase # => ABC
puts Transform.lowercase('XYZ') # => xyz
```

The key to this exercise is understanding the difference between class methods and instance methods. On `line 24` we call the `puts` method and pass in the return value of calling the **instance** method `#uppercase` on the `my_data` object (instantiated by the `Transform` class on `line 23`). On `line 25`, we call the `puts` method and pass in the return of calling the **class** method `#lowercase` and passing in the string `XYZ` as an argument.
