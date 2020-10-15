# problem2 - Question 2

# Alan created the following code to keep track of items for a shopping cart
# application he's writing:

class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

# Alyssa looked at the code and spotted a mistake. "This will fail when
# update_quantity is called", she says.

# Can you spot the mistake and how to address it?

# update_quantity requires a setter method and we currently only have a getter
# fix by changing :quantity to attr_accessor, also precede quantity with self
# or it will be local variable assignment

sale1 = InvoiceEntry.new('oreos', 35)
sale1.update_quantity(34)
p sale1.quantity
sale1.quantity = 30
p sale1.quantity
