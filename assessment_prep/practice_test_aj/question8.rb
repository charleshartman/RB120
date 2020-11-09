# question8.rb

class GroceryList
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def +(other_list)
    items.concat(other_list.items)
  end
end

bobs_list = GroceryList.new(["Carrots", "Milk"])
jims_list = GroceryList.new(["Hamburgers"])

joined_list = bobs_list + jims_list
p joined_list # => ["Carrots", "Milk", "Hamburgers"]
