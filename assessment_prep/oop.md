# OOP

---

*General OOP Benefits*

* The creation of objects within the OOP paradigm allows programmers to approach the design of software applications at a useful level of abstraction.
* Code can be reused throughout an application with little to no duplication, embracing the DRY (Don't repeat yourself) principle.
* The general mental model of OOP embraces an approach of breaking problems and solutions down into smaller pieces. This modularity may aid in initial development while also protecting existing code from new or altered pieces of a larger program. An OOP mindset helps manage complexity.
* OOP allows explicit and intentional design of the public interfaces (methods) available on a class and its resultant objects.

*Classes and Objects*

Objects are created from classes. Classes define the attributes and behaviors of the objects that are created from them. The attributes of an object are represented by its instance variables. An object's state is determined by the values that those instance variables reference. The behaviors available to an object are the instance methods defined within the object's class. All objects instantiated from a particular class have access to the same behaviors and attributes, but every object has its own state, which is determined by the values the those attributes point to.

Thus, classes can be thought of as molds or blueprints and objects as the execution of those plans. When we instantiate an object from a class we stamp out an individual instance of that class. Objects created from the same class have a pattern, or shape in common, but their instance variables may contain totally different values. This encapsulation of a collection of instance variables and their values makes up the object's state.

*Encapsulation*

Encapsulation lets us wall off data and pieces of functionality and serves as a method of data protection. It encourages a structure that allows access from the outside only when it is explicitly and intentionally designed to do so. This "sectioning off" has the added benefit of reinforcing a mental model that compartmentalizes data and methods in smaller, more manageable pieces. With encapsulation we determine what data (and perhaps methods) we wish to keep private and what data we wish to expose through an object's public methods.

*Modules*

Modules are Ruby's way of implementing multiple inheritance. We can *mixin* to a class as many modules as we wish. Modules are mixed in to a class using the include method invocation. Modules fall between the class and its superclass in the method lookup path. If more than one module is mixed in to a class, then the last module included will be the first module referenced in the method lookup path.
