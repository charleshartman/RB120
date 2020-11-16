
# Complete The Program - Houses

Assume you have the following code:

```ruby
class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end

  # def <(other)
  #   price < other.price
  # end
  
  # def >(other)
  #   price > other.price
  # end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# and this output:
# Home 1 is cheaper
# Home 2 is more expensive
```

Modify the House class so that the above program will work. You are permitted to define only one new method in House.

In Ruby `<` and `>` are actually methods that are sometimes referred to as 'fake operators'. Our custom class `House` does not have `#<` or `#>` methods, so as it is this program will generate a `NoMethodError`. A simple way to fix this by adding just one method is to `include` the `Comparable` mixin (module) and define a `#<=>` method based on it.

---

Another explanation with plus two methods:
In Ruby `<` and `>` are actually methods that are sometimes referred to as 'fake operators'. Our custom class `House` does not have `#<` or `#>` methods, so as it is this program will generate a `NoMethodError`. We need to define both of these methods within our `House` class. In this case, we define them to use `Integer#<` and `Integer#>` respectively.