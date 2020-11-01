# gallery_transaction_p4.rb

module Displayable; end

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

class Client
  attr_accessor :interests
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Artwork
  def initialize(artist, title, date)
    @artist = artist
    @title = title
    @date = date
  end
end

class Painting < Artwork
  def initialize(artist, title, date)
    super
    @medium = 'oil on canvas'
  end
end

class Photograph < Artwork
  def initialize(artist, title, date)
    super
    @medium = 'gelatin silver print'
  end
end

class Artist; end

john_gray = Client.new('John Gray')
satya_james = Client.new('Satya James')
p john_gray.name
p john_gray.interests

sale1 = Transaction.new(john_gray)
sale2 = Transaction.new(satya_james)
p sale1
p sale2

puts Transaction.total_transactions

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
p weston
van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
p van_gogh

# talk about inheritance, method lookup path and super
