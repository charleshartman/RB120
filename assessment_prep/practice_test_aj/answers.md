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

---

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

---

#### Question 4
> What is duck-typing? What are the benefits of duck-typing? (Bonus: How does duck-typing differ from normal-typing?) Provide an example of duck-typing in code.

Duck-typing is another way to implement *polymorphism* in Ruby. Rather than concerning itself with the class of a particular object, duck-typing is only concerned with what behaviors are available on the object in question. If an objects acts (or "quacks") like a duck, then we can treat it like a duck. There is no inheritance involved in duck-typing, instead we are simply accessing a common type of behavior across classes.

Example:

```ruby
class Gallery
  def make_exhibition(workers)
    workers.each do |worker|
      worker.mount_exhibition(self)
    end
  end
end

class Framer
  def mount_exhibition
    fit_artwork(exhibit.works)
  end

  def fit_artwork(works)
    # implementation
  end
end

class Artist
  def mount_exhibition
    create_artwork(exhibit.art)
  end

  def create_artwork(art)
    # implementation
  end
end

class Installer
  def mount_exhibition
    install_artwork(exhibit.hang)
  end

  def install_artwork(hang)
    # implementation
  end
end
```

---

#### Question 5
> Compare and contrast class and interface inheritance. When would you use one over the other?

*Class inheritance* occurs when a class (the subclass) inherits the behaviors of another class (the superclass). This allows more generalized behaviors for a certain class to be inherited by a subclass. The subclass can then extend and fine-tune those behaviors without excessive duplication of code. In this way the subclass specializes the superclass.

 Mixing modules in to a class can be described as *interface inheritance*. Rather than inheriting from a more general 'type', the class inherits useful methods that extend the class. Class inheritance is often described as an 'is-a' relationship, where interface inheritance (mixin modules) is a 'has-a' relationship.
 
 You can only subclass from one superclass. You can mix in as many modules as you like.

---

#### Question 6
> In the code below, what path does Ruby take to resolve the grow method call on the last line?

```ruby
module Growable; end
module Photosynthesizable; end
module Reproducable; end

class Plant
  def grow
    # implementation
  end
end

class Tree < Plant
  include Growable
end

class Salicaceae < Tree
  include Reproducable
  include Photosynthesizable
end

my_tree = Salicaceae.new
my_tree.grow

puts Salicaceae.ancestors
```

The method lookup path for my_tree.grow would be:

Salicaceae -> Photosynthesizable -> Reproducable -> Tree -> Growable -> Plant -> Object -> Kernel -> BasicObject

This can be checked by calling `Module#ancestors` on the `Salicaceae` class, as we have above.

---

#### Question 7

> What is a collaborator object? When is it best to use one? Include a code example to supplement your answer.

Collaborator objects are objects that are stored as state within another object. This 'collaboration' represents connections between various parts of the larger program and should be considered from the very beginnings of a program's design. 

In the code example below, the `john_grey` and `satya_james` `Client` objects are collaborator objects to the `sale1` and `sale2` `Transaction` objects.  

Example:

```ruby
class Transaction
  def initialize(client)
    @client = client
  end
end

class Client
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

john_grey = Client.new('John Grey')
satya_james = Client.new('Satya James')

sale1 = Transaction.new(john_grey)
sale2 = Transaction.new(satya_james)
```

---

#### Question 8

> One of the benefits and detriments of coding in Ruby is that false operators can be defined in custom classes. What are some things that are important to consider when defining a false operator method in a class (i.e. a + method)? Implement a + method in the code below, so that the code runs as expected.

As with OOP programming in general, when implementing fake operators in one's own custom methods, it is important to take an intentional and explicit approach. You should know if you are overriding an existing inherited method and consider the implications of that. Additionally, it is important to define fake operator methods that make sense in the context of the (fake) operator itself. For example, you would expect a custom `+` method to likely increment or concatenate with its argument, not multiply. I have implemented the appropriate `+` method in the example below.

```ruby
class GroceryList
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def +(other_list)
    items.concat(other_list.items)
  end
end

bobs_list = GroceryList.new(["Carrots", "Milk"])
jims_list = GroceryList.new(["Hamburgers"])

joined_list = bobs_list + jims_list
p joined_list # => ["Carrots", "Milk", "Hamburgers"]
```

---

#### Question 9

> Object oriented design is all about relationships between objects. Provide an example of code that includes the following associations:

> * an example of class inheritance
> * an example of interface inheritance
> * usage of a collaborator object or collaborator objects

```ruby
module Hangable
  MOUNTING = ['a cleat', 'picture hangers', 'nails']

  def affix_with
    puts "We suggest hanging this piece with #{MOUNTING.sample}."
  end
end

class Transaction
  include Displayable

  @@order_number = 0

  def initialize(client)
    @@order_number += 1
    @client = client
  end

  def self.total_transactions
    @@order_number
  end
end

class Client
  attr_accessor :interests
  attr_reader :name

  def initialize(name)
    @name = name
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

class Artist
  attr_reader :name, :birth, :death

  def initialize(name, birth, death = nil)
    @name = name
    @birth = birth
    @death = death
  end
end

john_grey = Client.new('John Grey')
satya_james = Client.new('Satya James')
john_grey.interests = ['Group f64', 'Modernism', 'FSA']

sale1 = Transaction.new(john_grey)
sale2 = Transaction.new(satya_james)
p sale1
p sale2
puts Transaction.total_transactions

edward_weston = Artist.new('Edward Weston', 1886, 1958)
vincent_van_gogh = Artist.new('Vincent van Gogh', 1853, 1890)
rae_davis = Artist.new('Rae Davis', 1970)
p edward_weston
p vincent_van_gogh
p rae_davis

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.affix_with
```
