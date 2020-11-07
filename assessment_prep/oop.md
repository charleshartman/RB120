# Object Oriented Programming with Ruby

## RB129 Study Guide - Charles Hartman

---

### General OOP Benefits

* The creation of objects within the OOP paradigm allows programmers to approach the design of software applications at a useful level of abstraction.
* Code can be reused throughout an application with little to no duplication, embracing the DRY (Don't repeat yourself) principle.
* The general mental model of OOP embraces an approach of breaking problems and solutions down into smaller pieces. This modularity may aid in initial development while also protecting existing code from new or altered pieces of a larger program. An OOP mindset helps manage complexity.
* OOP allows explicit and intentional design of the public interfaces (methods) available on a class and its resultant objects.


### Classes and Objects

Objects are created from classes. Classes define the attributes and behaviors of the objects that are created from them. The attributes of an object are represented by its instance variables. An object's state is determined by the values that those instance variables reference. The behaviors available to an object are the instance methods defined within the object's class. All objects instantiated from a particular class have access to the same behaviors and attributes, but every object has its own state, which is determined by the values the those attributes point to.

Thus, classes can be thought of as molds or blueprints and objects as the execution of those plans. When we instantiate an object from a class we stamp out an individual instance of that class. Objects created from the same class have a pattern, or shape in common, but their instance variables may contain totally different values. This encapsulation of a collection of instance variables and their values makes up the object's state.

### Encapsulation

Encapsulation lets us wall off data and pieces of functionality and serves as a method of data protection. When we instantiate a new object from a class, the object allows access from the outside through the object's instance variables, but only in a way that has been explicitly and intentionally designed. This "sectioning off" has the added benefit of reinforcing a mental model that compartmentalizes data and methods in smaller, more manageable pieces. With encapsulation, we determine what data (and perhaps methods) we wish to keep private and what data we wish to expose through an object's public methods.

### Inheritance

*Class inheritance* occurs when a class (the subclass) inherits the behaviors of another class (the superclass). This allows more generalized behaviors for a certain class to be inherited by a subclass. The subclass can then extend and fine-tune those behaviors without excessive duplication of code. In this way the subclass specializes the superclass.

 Mixing modules in to a class can be described as *interface inheritance*. Rather than inheriting from a more general 'type' the class inherits useful methods that extend the class. Class inheritance is often described as an 'is-a' relationship, where interface inheritance (mixin modules) is a 'has-a' relationship.
 
 You can only subclass from one superclass. You can mix in as many modules as you like.
 
 Example:

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

van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.affix_with
```

### attr_*

```ruby
class Artwork
	attr_accessor :artist, :title, :date
end
```

In the code above, we define the custom class `Artwork` with one method call. The `attr_accessor` method is built in to Ruby. When called, it automatically creates getter and setter methods for the instance variable specified by the symbol(s) that are passed in as an argument. In this case, we pass in `:artist, :title,` and `:date`. This will create `#artist`, `#title` and `#date`, as well as `#artist=`, `#title=` and `#date=`. We can then use those getter and setter methods to read and modify the instance variables `@artist`, `@title` and `@date`. `attr_reader` and `attr_writer` are related methods and create only getter or only setter methods respectively.

These setter and getter methods are instance methods and are called on objects instantiated from the custom class. The example below illustrates setting the instance variables for the object `van_gogh` and then changing the value that the `@date` instance variable is referencing.

```ruby
van_gogh = Artwork.new
van_gogh.artist = 'Vincent van Gogh'
van_gogh.title = 'The Starry Night'
van_gogh.date = 1911

puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"

van_gogh.date = 1889
puts "Corrected:\n"
puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"
```

### Class methods vs. Instance methods

Class methods are called on the class itself while instance methods are called on objects that have been instantiated by the class, thus class methods are used for functionality that does not pertain to individual objects.

Example:

```ruby
class Client
  def self.greeting
    puts "Greetings, Client! This is a class method."
  end

  def greet
    puts "Hola, client! This is an instance method."
  end
end

tom = Client.new
tom.greet
Client.greeting
```

### Modules

Modules are Ruby's way of implementing multiple inheritance. We can *mixin* to a class as many modules as we wish. Modules are mixed in to a class using the include method invocation. Modules fall between the object's class and its superclass in the method lookup path. If more than one module is mixed in to a class, then the last module included will be the first module referenced in the method lookup path.


### Method Lookup Path

Ruby has a distinct lookup path that it follows each time a method is called. Understanding this lookup path is essential to knowing where an object's call to an instance method will look for said method, and in what order in terms of class inheritance Ruby will look for the method. Ruby stops looking after it locates the first matching method in the path. You may see the method lookup path for a particular object by calling the `Module#ancestors` method on the object's class. When more than one module is "mixed in" to a class, the last module `include` is the first module in the method lookup path.

Example:

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


### Class variables

Class variables begin with `@@` and are scoped at the class level. Class variables are accessible by class methods, no matter where they are initialized. All objects instantiated from a class share one copy of each class variable. This makes it possible to share state between objects with class variables.

Example:

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
```


### Equality

Generally speaking, `==` in Ruby asks are the values the same, **not** are the objects the same. But, we must remember that `==` is a method, not an operator. So when we are calling `Array#==`, `Hash#==`, `Integer#==` or `String#==` it behaves in this way, but in a custom class `==` is inherited from `BasicObject#==` which asks if the objects are the same, rather than the values. Since `==` is a method, not an operator, we can define our own `==` and use the appropriate Array, Hash, String or Integer method instead.

Example:

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

puts bobby == robby
```

`equal?` asks if the objects are the same. It is the same as comparing `object_id`s. `===` is also a method, and is used implicitly in `case` statement evaluation. In the case of `(1..10) === 5` for example, it asks, 'if (1..10) is a group, would 5 be included in that group?'.
`eql?` asks if two objects have the same value and if they are of the class. It is most often used by Hash.

### Fake Operators

Many things that look like operators in Ruby are in fact methods.  For example, `===` and `+` are methods rather than operators. This means they can be implemented in our custom classes in a fine-tuned and intentional way. This flexibility, however, can also lead to confusion if we are not aware it. For this reason it is important to know explicitly what methods you are calling and if they need to be (re)defined within your class to perform as desired.

Example:

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
```

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

### self

Contexts for the keyword `self` in Ruby:
* when used within an instance method it refers to the calling object, that is, the object that called the method. We use `self` in this way when calling setter methods from within the class. This allows us to disambiguate between initializing a local variable and calling a setter method.
* `self` is also used for class method definitions

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
puts lulu.age
lulu.change_age(30)
puts lulu.age

NameTag.info
```

### Method Access Control

Another benefit of *encapsulation* and OOP is the ability to hide the internal representation of an object from the outside and be intentional about what interfaces are to be accessible through public methods. This is call *method access control*. This is implemented in Ruby through the use of `public`, `private` and `protected` access modifiers. A `public` method is accessible to anyone with the class name or object name. These methods can be used from outside the class and determine how other classes and objects interact with it. A `private` method is only usable from within the class and is not directly accessible from other parts of the program. A `protected` method acts like a `public` method from within the class, and a `private` method from outside the class. This allows for access between instances of the same class, but protects those objects from access outside the class.

Methods are `public` by default, to make a method `private` or `protected` we use their respective method calls in our program and anything below it will be `private` or `protected` respectively (unless superseded by another call to `public`, `private` or `protected`).

Example using `private`:

```ruby
class AddSeven
  SEVEN = 7

  def initialize(number)
    @number = number
    puts calculation
  end

  private

  def calculation
    @number + SEVEN
  end
end

AddSeven.new(14)
```

*finis*

