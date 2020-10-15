# problem1.rb - Question 1

# Which of the following are objects in Ruby? If they are objects, how can you
# find out what class they belong to?

# true
# "hello"
# [1, 2, 3, "happy days"]
# 142

# they are all objects. you can determine the class by calling
# Object#class on the object

p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class
