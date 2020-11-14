# fake_operators_ex3.rb

class ArtSupplies
  attr_accessor :items

  def initialize(items = [])
    @items = items
  end

  def +(other_list)
    combo_list = ArtSupplies.new
    combo_list.items = items + other_list.items
    combo_list
  end
end

lizzies_list = ArtSupplies.new(['watercolor paper', "no. 2 brush"])
lulus_list = ArtSupplies.new(['oxblood ink', 'linen canvas'])
p lizzies_list.items
p lulus_list.items

master_list = lizzies_list + lulus_list
p master_list.items
# => ["watercolor paper", "no. 2 brush", "oxblood ink", "linen canvas"]

lizzies_list.items << 'portfolio case'
p lizzies_list.items
