# problem2.rb - Question 2

# We have an Oracle class and a RoadTrip class that inherits from the
# Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future

# TLDR: the result is a return value of "You will " + one of three strings in
# three string array returned by calling instance method `choices` defined
# within the RoadTrip class. RoadTrip inherits predict the future from Oracle.
# Given the method lookup path, since trip is an instance of RoadTrip, it will
# use the choices method in RoadTrip (since that is the first place it looks).
