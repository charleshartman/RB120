# class_variable_ex1.rb

class Transaction
  @@order_number = 0

  def initialize(client)
    @@order_number += 1
    @client = client
  end

  def self.total_transactions
    @@order_number
  end
end

Transaction.new('John Grey')
Transaction.new('Satya James')
puts "Total transactions: #{Transaction.total_transactions}"
