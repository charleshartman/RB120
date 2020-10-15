# problem1.rb - Question 1

# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:

oracle = Oracle.new
p oracle.predict_the_future

# we initialize local variable `oracle` and assign to it a new instance of 
# `Class#Oracle`. `oracle` calls the instance method  `predict_the_future` which
# returns the concatenation of string object "You will " and the return value of
# calling `sample` on the return value of `choices`. This results in a random
# selection of one of three strings within a three string array.

# TLDR: the result is a return value of "You will " + one of three strings in
# three string array returned by calling instance method `choices`.
