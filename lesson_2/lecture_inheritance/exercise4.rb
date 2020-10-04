# exercise4.rb

# Method lookup path refers to the #ancestors hierarchy of a particular object.
# When an object invokes a particular method, the method is looked for first in
# the object's class, then in any included modules, starting with the last
# module 'included' then in each successive superclass.

# This path can be viewed by calling #ancestors on the object's class.

class Example
end

my_object = Example.new
p Example.ancestors
p my_object.class.ancestors


# The method lookup path is the order in which Ruby will traverse the class
# hierarchy to look for methods to invoke. For example, say you have a Bulldog
# object called bud and you call: bud.swim. Ruby will first look for a method
# called swim in the Bulldog class, then traverse up the chain of super-classes;
# it will invoke the first method called swim and stop its traversal.

# In our simple class hierarchy, it's pretty straight forward. Things can
# quickly get complicated in larger libraries or frameworks. To see the method
# lookup path, we can use the .ancestors class method.

Bulldog.ancestors       # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]

# Note that this method returns an array, and that all classes sub-class from
# Object. Don't worry about Kernel or BasicObject for now.