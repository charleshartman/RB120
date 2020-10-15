# problem3.rb - Question 3

# In the last question Alan showed Alyssa this code which keeps track of items
# for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end

  private

  attr_writer :quantity
end

# Alyssa noticed that this will fail when update_quantity is called. Since
# quantity is an instance variable, it must be accessed with the @quantity
# notation when setting it. One way to fix this is to change attr_reader
# to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# this exposes quantity to modification outside the method. we could make the
# setter method for quantity private (still beginning method call with self) so
# that quantity can only be changed by an external call to update_quantity, but
# not a direct call to quantity

sale1 = InvoiceEntry.new('oreos', 35)
sale1.update_quantity(34)
p sale1.quantity
sale1.quantity = 30 # => NoMethodError exception now because private
