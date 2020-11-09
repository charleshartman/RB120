# tree.rb

class Tree
  attr_reader :log_number, :common_name, :genus, :location

  @@inventory_number = 0

  def initialize(common_name, genus, location)
    @log_number = next_number
    @common_name = common_name
    @genus = genus
    @location = location
  end

  def next_number
    @@inventory_number += 1
  end

  def to_s
    "Tree number #{@@inventory_number} is a #{common_name} of genus " \
    "#{genus}. It is located at #{location}."
  end
end

tree1 = Tree.new('Maple', 'Acer', '134 NW 8th Ave')
p tree1
puts tree1

tree2 = Tree.new('Aspen', 'Populus', '43 Linhart Ln')
p tree2
puts tree2
