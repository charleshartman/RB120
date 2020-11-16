
# Fix The Program - Expander

What is wrong with the following code? What fix(es) would you make?

```ruby
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3) # changed from self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
```

We need to remove the explicit `self` on `line 13` because `private` methods can not be called with an explicit caller. 
