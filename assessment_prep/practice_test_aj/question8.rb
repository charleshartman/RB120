# question8.rb

class GroceryList
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def +(other_list)
    combo_list = GroceryList.new
    combo_list.items = items.concat(other_list.items)
    combo_list
  end
end

bobs_list = GroceryList.new(["Carrots", "Milk"])
jims_list = GroceryList.new(["Hamburgers"])

joined_list = bobs_list + jims_list
p joined_list.items # => ["Carrots", "Milk", "Hamburgers"]
