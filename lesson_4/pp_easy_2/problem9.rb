# problem9.rb - Question 9

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    # rules of play
  end

  def play
    "No, I'll start the game!"
  end
end

# What would happen if we added a play method to the Bingo class, keeping in
# mind that there is already a method of this name in the Game class that the
# Bingo class inherits from.

# the play method in Bingo would be the first play method in the method lookup
# path for any Bingo instantiated objects... so it would be the method called
# were we to do:

p Bingo.new.play
