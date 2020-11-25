# Object Oriented Programming with Ruby

## RB129 Study Guide - Charles Hartman

---

### General OOP Benefits

Object Oriented Programming allows us to think about solving problems and designing programs at a more abstract level. When presented with creating a larger, more complex program our first goal is to truly understand the problem at hand. This typically means breaking it down into smaller pieces and examining it from multiple angles. Even if we don't need to 'break it down' to understand it, we will most certainly need to do so to construct a solution. OOP is a natural extension of this 'building blocks' mindset and helps us both manage complexity and code with intention.

This modular approach to designing classes and creating objects serves to protect data and interfaces, only allowing access when we explicitly and intentionally permit it. With OOP, we can define the public interfaces (methods) available on a class (and its resultant objects) with a great degree of control and precision. This approach decreases dependancies, allowing us to more easily make changes to our program without creating ripple effects that flow through (and potentially break) other parts of our codebase. OOP also supports and encourages adherence to the DRY (Don't repeat yourself) principle, by making it easier to reuse pieces of code and avoid duplication.

---

### Classes and Objects

Objects are created from classes. Classes define the attributes and behaviors of the objects that are created from them. The attributes of an object are represented by its instance variables. An object's state is determined by the values that those instance variables reference. The behaviors available to an object are the instance methods defined within the object's class. All objects instantiated from a particular class have access to the same behaviors and attributes, but every object has its own state, which is determined by the values those attributes (instance variables) point to.

Thus, classes can be thought of as blueprints and objects as the execution of those plans. When we instantiate an object from a class we construct an individual instance of that class. Objects created from the same class have a pattern or shape in common, but their instance variables may reference totally different values. This *encapsulation* of a collection of instance variables and the values they reference make up the object's state. 

In the example below we instantiate two different objects from the `ArtWork` class and assign them to local variables `van_gogh` and `weston`. When we call `puts` and pass `van_gogh` and `weston` in as arguments the `Object#to_s` method returns the name of the object's class and an encoding of the object id. These are different objects, with different object ids, each encapsulating its own state.

```ruby
class ArtWork
  def initialize(artist, title, date)
    @artist = artist
    @title = title
    @date = date
  end
end

van_gogh = ArtWork.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
# => #<ArtWork:0x00007fe3f88400b0> (encoding of object id may differ)

weston = ArtWork.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
# => #<ArtWork:0x00007fca45833cb0> (encoding of object id may differ)
```

---

### Polymorphism

In Ruby, polymorphism is most generally described as the ability of objects of different types to respond **in different ways** to the same message (or method invocation). This can be accomplished through *inheritance*, by extending or redefining behaviors in subclasses more fine-tuned to their specific data. This allows us to reuse as well as refine behaviors while adhering to the principle of DRY (Don't Repeat Yourself). Polymorphism can also be achieved through the use of *modules* (mixins) that provide additional shared behaviors to objects. 

An example of polymorphism through inheritance and with modules can be found below in the [[Class and Interface Inheritance]] section.

Another way to implement polymorphism is through *duck-typing*. Duck-typing does not care about the class of object, it only cares about the interface available on the object. In other words, it is concerned with what an object can do and what messages it can respond to. There is no inheritance involved in duck-typing, instead we are simply accessing a common type of behavior across classes.

Polymorphism through duck-typing example:

```ruby
class Cutting
  def knife(workers)
    workers.each(&:cut)
  end
end

class Logger
  def cut
    puts "I am slicing the logs! Timberrrr!"
  end
end

class Chef
  def cut
    puts "Chopping these onions is making me cry."
  end
end

class Seamstress
  def cut
    puts "I use very sharp scissors to cut my thread."
  end
end

Cutting.new.knife([Logger.new, Chef.new, Seamstress.new])
# =>
# I am slicing the logs! Timberrrr!
# Chopping these onions is making me cry.
# I use very sharp scissors to cut my thread.
```

Above we call `#knife` on our `Cutting` instance, and pass in an array of three objects: `Logger`, `Chef`, and `Seamstress`. The only thing we care about here is that each of those objects can `#cut`, that is, each of them have the appropriate public interface available.

---

### Encapsulation

Encapsulation lets us wall off data and pieces of functionality and serves as a method of data protection. When we instantiate a new object from a class, the object allows access from the outside through the object's public methods and instance variables, but only in a way that has been explicitly and intentionally designed. This "sectioning off" has the added benefit of reinforcing a mental model that compartmentalizes data and methods in smaller, more manageable pieces. With encapsulation, we determine what data and methods we wish to keep private and what data we wish to expose through an object's public methods

---

### Class and Interface Inheritance

*Class inheritance* occurs when a class (the subclass) inherits the behaviors of another class (the superclass). This allows more generalized behaviors for a certain class to be inherited by a subclass. The subclass can then extend and fine-tune those behaviors without excessive duplication of code. In this way the subclass specializes the superclass.

Mixing modules in to a class can be described as *interface inheritance*. Rather than inheriting from a more general 'type', the class inherits useful methods that extend the class. Class inheritance is often described as an 'is-a' relationship, whereas interface inheritance with modules is a 'has-a' relationship. While you can only subclass from one superclass, but you may mix in as many modules as you like. (Note: objects can be instantiated from classes but not from modules.)
 
Class and interface inheritance example:

```ruby
module Hangable
  def hang_with
    puts "We suggest hanging this piece with #{hardware}."
  end
end

class Artwork
  include Hangable

  attr_reader :artist, :title, :date, :medium

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
  def initialize(artist, title, date)
    super
    @medium = 'oil on canvas'
  end

  def hardware
    "picture hangers"
  end
end

class Photograph < Artwork
  def initialize(artist, title, date)
    super
    @medium = 'gelatin silver print'
  end

  def hardware
    "a cleat"
  end
end

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
# => Edward Weston, Pepper No. 30, 1930. Gelatin silver print.
weston.hang_with
# => We suggest hanging this piece with a cleat.

van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
# => Vincent van Gogh, The Starry Night, 1889. Oil on canvas.
van_gogh.hang_with
# => We suggest hanging this piece with picture hangers.
```

In this example, `Painting` and `Photograph` both inherit from `Artwork`, so it serves as superclass to their respective subclasses. In both cases part of the `#initialize` method is inherited with additional refinements (addition of `@medium` with different value) being made in the subclass. We also inherit the `#hang_with` interface (method) from our `Hangable` mixin module. `Painting` and `Photograph` have an 'is-a' relationship with `Artwork`, whereas `Artwork`, `Painting` and `Photograph` have a 'has-a' relationship with `Hangable`. In other words, a `Photograph` **is a** `Artwork` and an `Artwork` **has a** `Hangable` aspect.

---

### attr_*

```ruby
class Artwork
	attr_accessor :artist, :title, :date
end
```

In the code above, we define the custom class `Artwork` with one method call. The `attr_accessor` method is built in to Ruby. When called, it automatically creates getter and setter methods for the instance variable specified by the symbol(s) that are passed in as an argument. In this case, we pass in `:artist,` `:title,` and `:date`. This will create `#artist`, `#title` and `#date`, as well as `#artist=`, `#title=` and `#date=`. We can then use those getter and setter methods to read and modify the instance variables `@artist`, `@title` and `@date`. `attr_reader` and `attr_writer` are related methods and create only getter or only setter methods respectively.

These setter and getter methods are instance methods and are called on objects instantiated from the custom class. The example below (in addition to our class definition above) illustrates setting the instance variables for the object referenced by local variable `van_gogh` and then changing the value that the `@date` instance variable is referencing.

```ruby
van_gogh = Artwork.new
van_gogh.artist = 'Vincent van Gogh'
van_gogh.title = 'The Starry Night'
van_gogh.date = 1911

puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"
# => Vincent van Gogh, The Starry Night, 1911

van_gogh.date = 1889

puts "Corrected:\n"
puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"
# => Corrected:
# => Vincent van Gogh, The Starry Night, 1889
```

---

### Class methods vs. Instance methods

Class methods are called on the class itself while instance methods are called on objects that have been instantiated by the class, thus class methods are used for functionality that does not pertain to individual objects.

In the example below, the object that local variable `tom` is pointing to invokes the instance method `#greet`, whereas the `Client` class itself invokes the class method `#greeting`. (Note that we prepend the keyword `self` to the method name when defining a class method.)

```ruby
class Client
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.greeting
    puts "Greetings, #{self}! This is a class method."
  end

  def greet
    puts "Hola, #{name}! This is an instance method."
  end
end

tom = Client.new('Tom')
tom.greet
# => Hola, Tom! This is an instance method.

Client.greeting
# => Greetings, Client! This is a class method.
```

---

### Modules

Modules are Ruby's way of implementing multiple inheritance. We can *mixin* to a class as many modules as we wish. Modules are mixed in to a class using the `include` method invocation. Modules fall between the object's `class` and its `superclass` in the method lookup path. If more than one module is mixed in to a class, then the last module included will be the first module referenced in the method lookup path. In the following example, we `include` the `Portable` module in the `Bag` class to extend this related method, `#carry` to `Bag` but not to the more general `Container` superclass or its other subclass, `Crate`, where this behavior does not fit.

```ruby
module Portable
  def carry
    "You can transport this by hand."
  end
end

class Container; end

class Crate < Container; end

class Bag < Container
  include Portable

  attr_reader :type, :color

  def initialize(type, color)
    @type = type
    @color = color
  end
end

baggu = Bag.new('nylon', 'blue')
puts baggu.carry
# => You can transport this by hand.
```

Modules may also be used for *namespacing*, grouping similar classes together. This helps us organize our code and has the advantage of helping to avoid collisions between similarly named classes in our program. In the example below, we group three similar `Creatures` together in a single module and demonstrate how we can instantiate objects from classes defined within modules.

```ruby
module Creatures
  class Arachnid
    def legs
      puts "I have eight legs."
    end
  end

  class Raccoon
    def paws 
      puts "I have four paws."
    end
  end

  class Zombie
    def feet
      puts "I have ACK!.... BRAINS.... two feet?"
    end
  end
end

Creatures::Zombie.new.feet
Creatures::Raccoon.new.paws
Creatures::Arachnid.new.legs
```

Additionally, modules may be used as *containers* for methods that don't fit elsewhere in our program. These module methods can be called directly from the module. An example:

```ruby
module Consolable
  def self.prompt_purple(msg)
    puts "\e[34m#{msg}\e[0m"
  end
end

Consolable.prompt_purple("This method doesn't fit elsewhere.")
```

---

### Method Lookup Path

Ruby has a distinct lookup path that it follows each time a method is called. Understanding this lookup path is essential to knowing where an object's call to an instance method will first look for the method, and in what order it will continue to look for the method should it not find it in the calling object's class. Ruby stops looking after it locates the first matching method in the path. Generally speaking, Ruby looks first the object's class, then to any modules included in that class. When more than one module is included or "mixed in" to a class, the last module included is the first module searched in the method lookup path. Ruby then proceeds to the object's superclass, modules, then the superclass of that class and so on and so on.
 
You may see the method lookup path for a particular object by calling the `#ancestors` method on the object's class. The example below shows the behavior described above in terms of (multiple) modules as well as how the method lookup path continues through the applicable built-in Ruby classes and modules.

```ruby
module Displayable; end

module Collectible; end

class Client
  include Displayable
  include Collectible

  def initialize(name)
    @name = name
  end
end

puts Client.ancestors 

# Client
# Collectible
# Displayable
# Object
# Kernel
# BasicObject
```

---

### Class variables

Class variables begin with `@@` and are scoped at the class level. Class variables are accessible by class methods as well as instance methods, no matter where they are initialized. All objects instantiated from a class share one copy of each class variable. This makes it possible to share state between objects with class variables. This also means we should avoid using class variables when working with inheritance as it is very easy to reassign the value of a class variable in a subclass and thus create problems for objects of the superclass or other subclasses sharing that state.

This example does not involve inheritance and illustrates using a class variable to keep track of how many objects of the given class have been instantiated:

```ruby
class Transaction
  @@order_number = 0

  def initialize(client)
    @@order_number += 1
    @client = client
  end

  def self.total_transactions
    @@order_number
  end
end

Transaction.new('John Grey')
Transaction.new('Satya James')
puts "Total transactions: #{Transaction.total_transactions}"
# => Total transactions: 2
```

---

### Constants and Lexical Scope

Constants have different scoping rules than other variables. The key difference being that constant resolution looks to *lexical scope* first. If the constant is not located in the lexical scope of method seeking its value, it will then proceed to search through the method's inheritance hierarchy.

The following example illustrates this:

```ruby
class Creature
  LEGS = 2

  def how_many_legs
    puts "#{self.class}s walk on #{LEGS} legs."
  end
end

class Arachnid < Creature
  LEGS = 8
end

spider = Arachnid.new
spider.how_many_legs # => Arachnids walk on 2 legs.
```

Since Ruby looks first to lexical scope, we do not get the result we are expecting from the code above. When our calling object `spider` calls `#how_many_legs`, the method is not found in `Arachnid` so Ruby proceeds up the method lookup chain to `Creature`. Having found the method there, Ruby looks within the lexical scope of `Creature` first for the `LEGS` constant and finds `LEGS = 2`. Note that if `LEGS` was not initialized and assigned a value in `Creature`, Ruby would generate an error: `NameError: uninitialized constant`, it would not "go back" to `Arachnid` to look for `LEGS`. We need to give Ruby more explicit direction about where to look for the constant. We can use the namespace resolution operator `::` to achieve this. While `Arachnid::LEGS` would achieve the desired result in this case, a better solution would be explicitly accessing `LEGS` from the calling object's class with `self.class::LEGS`. That way calls to `Creature` objects return the desired number of legs as well. 

Corrected code example:

```ruby
class Creature
  LEGS = 2

  def how_many_legs
    puts "#{self.class}s walk on #{self.class::LEGS} legs."
  end
end

class Arachnid < Creature
  LEGS = 8
end

spider = Arachnid.new
spider.how_many_legs # => Arachnids walk on 8 legs.
zombie = Creature.new
zombie.how_many_legs # => Creatures walk on 2 legs.
```

---

### Equality

Generally speaking, `==` in Ruby asks are the values the same, **not** are the objects the same. We must remember, however, that `==` is a method, not an operator. It is one of many methods that look like operators that are often referred to as **fake operators**. So while the `Array#==`, `Hash#==`, `Integer#==` or `String#==` methods compare values, in a custom class `#==` is inherited from `BasicObject#==` which instead asks if the **objects** are the same. However, since `==` is a method, not an operator, we can define our own `#==` and use the appropriate `Array#==`, `Hash#==`, `String#==` or `Integer#==` method instead.

In the example below we define our own `#==` with `String#==`. We can see that our `NameTag#==` tests for string value equality rather than if the objects are the same.

```ruby
class NameTag
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end

bobby = NameTag.new('Robert')
robby = NameTag.new('Robert')

puts bobby == robby # => true

puts bobby 
# => #<NameTag:0x00007f9f558401b0> (encoding of object id may differ)
puts robby 
# => #<NameTag:0x00007f9f55840138> (encoding of object id may differ)
```

`equal?` asks if the objects are the same. It is the same as comparing `object_id`s. 

`===` is also a method, and is used implicitly in `case` statement evaluation. In the case of `(1..10) === 5` for example, it asks, "if (1..10) is a group, would 5 be included in that group?".

`eql?` asks if two objects have the same value and if they are of the same class. `eql?` is most often used by Hash.

---

### Fake Operators

As demonstrated with `#==` in the [[Equality]] section above, many things that look like operators in Ruby are in fact methods.  For example, `===` and `+` are methods rather than operators. This means they can be implemented in our custom classes in a fine-tuned and intentional way. This flexibility, however, can also lead to confusion if we are not aware it. For this reason it is important to know **explicitly** what methods you are calling and if they need to be (re)defined within your class to perform as desired.

In this example we simply define our own `#+` using `Integer#+`.

```ruby
class NameTag
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def +(other)
    age + other.age
  end
end

lulu = NameTag.new('Lulu', 29)
lizzie = NameTag.new('Elizabeth', 71)

puts lulu + lizzie
# => 100
```

In this example our objective is to return a new object of the same type as the calling object, so we instantiate that object within our custom `#+` and then assign to it's `@items` instance variable the return value  of calling `Array#+` on `lizzies_list.items` and passing `lulus_list.items` in as an argument.

```ruby
class ArtSupplies
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def +(other_list)
    combo_list = ArtSupplies.new
    combo_list.items = items + other_list.items
    combo_list
  end
end

lizzies_list = ArtSupplies.new(['watercolor paper', "no. 2 brush"])
lulus_list = ArtSupplies.new(['oxblood ink', 'linen canvas'])

master_list = lizzies_list + lulus_list
p master_list.items
# => ["watercolor paper", "no. 2 brush", "oxblood ink", "linen canvas"]
```

---

### Collaborator Objects

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

### self

Contexts for the **keyword** `self` in Ruby:
* when used within an instance method `self` refers to the calling object, that is, the object that called the method. We use `self` in this way when calling setter methods from within the class. This allows us to distinguish between initializing a local variable and calling a setter method.
* `self` is also used for class method definitions (by prepending `self` to the method name)

Example:

```ruby
class NameTag
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_age(new_age)
    self.age = new_age
  end

  def self.info
    puts "This is a class method, called by the #{self} class."
  end

  private

  attr_writer :age
end

lulu = NameTag.new('Lulu', 29)
puts lulu.age # => 29

lulu.change_age(30)
puts lulu.age # => 30

NameTag.info
# => This is a class method, called by the NameTag class.
```

---

### Method Access Control

Another benefit of *encapsulation* and OOP is the ability to hide the internal details of an object and be intentional about what interfaces on the object are accessible from the outside through public methods. This is call *method access control*. This is implemented in Ruby through the use of `public`, `private` and `protected` access modifiers. (Note that `public`, `private` and `protected` are also methods.) A `public` method is accessible to anyone with the class name or object name. These methods can be used from outside the class and determine how other classes and objects interact with it. A `private` method is only usable from within the class and is not directly accessible from other parts of the program. A `protected` method acts like a `public` method from within the class, and a `private` method from outside the class. This allows for access between instances of the same class, but protects those objects from access outside the class. To reiterate, a `protected` method can be accessed from other instances of the same class and a `private` method cannot.

Methods are `public` by default, to make a method `private` or `protected` we use their respective method calls in our program and anything below it will be `private` or `protected` respectively (unless superseded by another call to `public`, `private` or `protected`).

Example using `private`:

```ruby
class Greeting
  def hello
    "Greetings, " + padlocked
  end

  private

  def padlocked
    "Earthling!"
  end
end

alien = Greeting.new
puts alien.hello     # this works
puts alien.padlocked # But not this => private/NoMethodError
```

Example using `protected`:

```ruby
class HighScore
  include Comparable

  def initialize(score)
    @score = score
  end

  def <=>(other)
    score <=> other.score
  end

  protected

  attr_reader :score
end

lizzie_score = HighScore.new(28736)
lulu_score = HighScore.new(56732)

if lizzie_score > lulu_score
  puts "Lizzie has the highest score."
elsif lulu_score > lizzie_score
  puts "Lulu has the highest score."
end

# => Lulu has the highest score.
```

*finis*
