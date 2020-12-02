## RB129 Interview - Talking Points

### General OOP Benefits
- think at a level of abstraction
- encourages 'building blocks' thinking
- DRY (Don't Repeat Yourself)
- data Protection
- explicit and intentional design

### Classes and Objects
- objects are created from classes
- classes are blueprints for objects
- reserved words `class` and `end`, name in `CamelCase` format
- every object has its own **state**, which are its instance variables and the values they reference

### Polymorphism
- the ability of objects of different types to respond **in different ways** to the same message (or method invocation)
- accomplished through:
	- class inheritance 
	- interface inheritance (mixin modules)
	- duck-typing (we don't care about the class, only the interface aka methods available on the object)
- supports DRY, limits duplication

### Encapsulation
- objects **encapsulate** state
- each object has its own state
- intentional design lets us wall off data and methods and determine/control access to the object by explicitly determining its **public interface**
- accomplished through *method access control* (`public`, `private`, `protected`)
- metaphor of ports: standardized(`public`) vs proprietary(`protected`) vs no port available (`private`)

### Class and Interface Inheritance
- class inheritance: (sub)class inherits from a single superclass, refine/redefine the superclass 'is-a' relationship
- interface inheritance: mixin modules, as many as you wish, 'has-a' relationship

### getter and setter methods
- provide access to an object's instance variables and the values they point to, thus getters and setters permit us to read and write to an object's state
- can be defined *manually* or by using `attr_*` methods
- instance methods called on objects instantiated from the custom class
- subject to method access control (like other instance methods)

### more on attr_* methods
- when called, `attr_accessor` automatically creates getter and setter methods for the instance variable specified by the symbol(s) that are passed in as an argument
- getter only: `attr_reader`
- setter only: `attr_writer`

### Class methods vs. Instance methods
- class methods are called on the class itself
- instance methods are called on objects that have been instantiated by the class
- class methods are used for functionality that does not pertain to individual objects

### Modules
- way of implementing multiple inheritance
- *has-a* relationship
- we can *mixin* to a class as many modules as we wish
- modules are mixed in to a class using the `include` method invocation
- modules fall between the object's `class` and its `superclass` in the method lookup path
- if more than one module is mixed in to a class, then the last module included will be the first module referenced in the method lookup path
- can be used for grouping similar classes together: *namespacing*
- can be used for methods that don't fit elsewhere: *containers* (support staff)
- access classes within modules with namespace resolution operator `::`, for example: `Creatures::Zombie`

### Constructors
- invoke the class method `::new` on the class to instantiate a new instance of the class
- if `#initialize` is defined on the class it will be automatically called upon instantiation of a new object of the class, thus `#initialize` is a *constructor*

### Method Lookup Path
- a distinct lookup path is followed each time a method is called
- understanding this lookup path is essential 
- search ends after the first matching method in the path is found
- search first the object's class, then to any modules included in that class
- when more than one module is included or "mixed in" to a class, the last module included is the first module searched in the method lookup path. 
- after custom classes/modules, Ruby will always look to `Object`, `Kernel`, and `BasicObject` in that order.
- calling the `#ancestors` method on the object's class returns the method lookup path

### super
- lets us call methods further along the method lookup path
- `super` sends all arguments along
- `super(arg1, arg2)` sends selected arguments along
- `super()` sends **no** arguments along - one might use this if one wanted to use the passed in arguments in a subclass invocation of a method, but still wanted a piece of functionality from the superclass version of the method

### Class variables
- begin with `@@` and are scoped at the class level
- all objects instantiated by a particular class share one copy of a class variable
- class variables allow objects to share state
- do not use with inheritance, very easy to do unintentional things

### Truthiness
- prior teachings apply

### Constants and Lexical Scope
- constant resolution always looks to *lexical scope* first
- *lexical scope* is close vicinity (for example inside the same class or module as the method called)

### Equality
- `==` is a method, not an operator... it is a 'fake operator'
- `#==` is generally expected to compare the value of objects, but in custom classes it inherits from `BasicObject#==` which compares the objects themselves
- so we often define `#==` in our custom class and use use the appropriate `Array#==`, `Hash#==`, `String#==` or `Integer#==` method instead
- `equal?` compares objects (ids) and should not be redefined
- `#===` is used in case statements and asks given group `(1..10)` is `5` part of that group?
- `eql?` asks if objects contain the same value and are they of the same class

### Fake Operators
- many things that look like operators in Ruby are in fact methods
- this means that we can ‌(re)define these methods in our custom classes
- this is powerful but must be done with clarity and intention to avoid confusion and unintended consequences
- these 'fake operator' methods should act in line with their respective 'operator-like' expectations

### Collaborator Objects
- lets us store objects as state within other objects
- collaboration represents connections between various parts of larger program
- we can think of collaborator objects as 'super pointers'
- should be considered from the very beginning of code design

### self
- when defining a *class method*, we prepend it to the name of the method to identify it as a class method
- used within an *instance method* to distinguish it from local variable assignment behavior.
- `self` always refers to the caller
	- with class methods, it refers to the calling class 
	- with instance methods it refers to the calling object and lets Ruby know that we are calling a method on that object rather than initializing a local variable of that name.

### Method Access Control
- these are methods, also called access modifiers
	- `public`(default): access from outside to anyone with class or object name
	- `private`: only accessible from within the class
	- `protected`: like `private` from outside the class and `public` from within the class
- lets us protect data and methods and only allow intentionally designed access
- crucial to defining boundaries and walling-off data and methods as we encapsulate state and hide the internal representation of an object
- call `private` or `protected` and everything below the invocation is classified thus unless you make another call to `public`, `private` or `protected` to (re)set thus

*finis*