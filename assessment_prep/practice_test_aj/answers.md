# RB129 Practice Test

### Answers

---

#### Question 1
> What does the following code output? What does this tell us about variable scope, and particularly lexical scope, in Ruby? How could we change the code to ensure the proper output?

```ruby
class Humanoid
  EYES = 2
  attr_reader :eyes

  def initialize
    @eyes = 2
  end

  def number_of_eyes
    puts "Members of the #{self.class} class have #{eyes} eyes."
  end

  def self.number_of_eyes
    puts "Members of the #{self} class have #{EYES} eyes."
  end
end

class Cyclops < Humanoid
  EYES = 1
  attr_reader :eyes

  def initialize
    @eyes = 1
  end
end

cyclops = Cyclops.new

cyclops.number_of_eyes
# "Members of the Cyclops class have 1 eyes."
Cyclops.number_of_eyes
# "Members of the Cyclops class have 2 eyes."
```

While the first output is what we should expect, the second output is not. This is because of the lexical scope of constants in Ruby. When we call `number_of_eyes` on the object `cyclops` it does not find the method in `Cyclops`, so it precedes up the method lookup chain and finds in `Humanoid`. The method then calls `self.class` and `eyes` and interpolates the return values into the given string argument. We then call the `puts` method and pass in the string as an argument. This outputs the string and returns nil. `self.class` calls the `class` method on the calling object, `cyclops` which returns `Cyclops`. `eyes` calls the `eyes` getter method. Even though we had to go up the method lookup chain to find the `number_of_eyes` method, when we call instance methods from within the `number_of_eyes` method in `Humanoid`, Ruby still starts method lookup from the calling object's class (`Cyclops`). Since `Cyclops` has a getter method for `eyes` and `@eyes` was assigned a value of `1` when `cyclops` was initialized, the call to `eyes` returns `1`.

The second output is perhaps not what we would expect if we do not understand lexical scope as applied, in this case, to constants. In this case, we call the **class** method `number_of_eyes` on the `Cyclops` class. This method calls the puts method and passes in a string as an argument. There are two values interpolated into this string. The keyword `self` here simply returns `Cyclops`, the class that called the (class) method. `EYES` returns the value that the constant `EYES` is pointing to. Unlike methods, Ruby looks for this value in the immediate lexical scope rather than starting at the bottom the the method lookup chain as it did before. Since it finds an `EYES` constant in `Humanoid`, it returns the value it is pointing to, which is `2`. There are multiple ways to fix this problem. The cleanest way, since the presence of these constants is redundant, would be to get rid of the constants altogether and simply use the @eyes instance variables. If keeping the constants was somehow necessary then you could simply define the `number_of_eyes` class method in the `Cyclops` class as well as `Humanoid`. This violates DRY however. Lastly, you could explicitly point to `Cyclops::EYES` in the string interpolation. This would achieve the correct result in the case of the Cyclops class, but then introduce problems were you to call the `number_of_eyes` class method on `Humanoid`.

---

#### Question 2
> Polymorphism is a core tenet of object-oriented programming. How can polymorphism be implemented in Ruby? What are some of the benefits and detriments of polymorphism? Provide an example of polymorphism in code.

Literally, polymorphism means the ability to take on many forms or shapes. In Ruby, it is most generally described as the ability of different objects to respond in different ways to the same message (or method invocation)... or "the ability for different types of data to respond to a common interface." This can be accomplished through inheritance, by redefining specific behaviors in subclasses more fine-tuned for their specific data. This allows us to reuse as well as refine (or redefine) behaviors while adhering to the principle of DRY (Don't Repeat Yourself). Polymorphism can also be achieved through the use of modules (mixins) that provide additional shared behaviors to objects. 

Polymorphism in Ruby benefits us by allowing us to reuse code and thus prevent duplication in our code base. It encourages a compartmentalized or "building blocks" approach to overall program structure and design and is crucial to an OOP "mindset". A code example illustrating polymorphism through class inheritance as well as modules is below.

```ruby
module Hangable
  MOUNTING = ['a cleat', 'picture hangers', 'nails']

  def affix_with
    puts "We suggest hanging this piece with #{MOUNTING.sample}."
  end
end

class Artwork
  include Hangable

  attr_reader :artist, :title, :date

  def initialize(artist, title, date)
    @artist = artist
    @title = title
    @date = date
  end

  def to_s
    "#{artist}, #{title}, #{date}. #{medium.capitalize}."
  end
end

class Painting < Artwork
  attr_reader :medium

  def initialize(artist, title, date)
    super
    @medium = 'oil on canvas'
  end
end

class Photograph < Artwork
  attr_reader :medium

  def initialize(artist, title, date)
    super
    @medium = 'gelatin silver print'
  end
end

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.affix_with
```

#### Question 3
> The code below doesn't run quite as expected. What's wrong with it, and what does this tell us about class variables and class inheritance? Include in your answer the code you would use to produce the anticipated result.

```ruby
class House
  @@number_of_houses = 0

  def initialize
    @@number_of_houses += 1
  end

  def self.number
    @@number_of_houses
  end
end

class Room < House
  def initialize; end # <== change made here
end

my_house = House.new
p my_house
puts "Number of houses: #{House.number}"

living_room = Room.new
p living_room
puts "Number of houses: #{House.number}"
```

The class method `House#number` returns the value that the class variable `@@number_of_houses` is pointing to. @@number_of_houses is assigned to `0` when initialized and incremented by `1` every time an object of the `House` class is instantiated. `Room` is a subclass of `House` and inherits from it. Since `Room` does not define an `initialize` method to supersede `House#initialize`, instantiating a new `Room` object will call the `House#initialize` method automatically, which, as already noted, will increment the `@@number_of_houses` class variable. One way to correct this would be to define an `initialize` method for class `Room`, so new `Room` objects find `Room#initialize` and no longer follow the method lookup path on to `House` for the `initialize` method. We have made this change to the code above.
