# another_tree.rb

class Tree
  attr_accessor :nick, :genus
  attr_reader :location

  @@number_of_trees = 0

  def initialize(nick, location, genus='need to identify genus')
    @nick = nick
    @location = location
    @genus = genus
    @@number_of_trees += 1
  end
end

p Tree.class
