
# What Will This Do?

What will the following code print?

```ruby
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata # => ByeBye
puts thing.dupdata # => HelloHello
```

The point of this exercise is to understand the difference between defining and invoking instance methods and class methods. On `line 21` we initialize local variable `thing` and assign to it a new instance of the `Something` class instantiated by invoking the `BasicObject::new` class method. On `line 22` we call the `puts` method on the return value of calling the `#dupdata` class method on `Something`. This prints `ByeBye` and returns `nil`. On `line 23` we call the `puts` method on the return value of calling the `#dupdata` instance method on the object assigned to local variable `thing`. This method returns the concatenation of the string value referenced by instance variable `@data` and itself (`@data + @data`), so the call to `puts` on `line 23` prints `HelloHello` and returns `nil`.
