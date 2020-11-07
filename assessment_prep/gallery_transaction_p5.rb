# gallery_transaction_p5.rb

module Displayable
  def clear_screen
    system 'clear'
    system 'cls'
  end

  def prompt_purple(msg)
    puts "\e[34m#{msg}\e[0m"
  end

  def prompt_green(msg)
    puts "\e[32m#{msg}\e[0m"
  end
end

module Hangable
  MOUNTING = ['a cleat', 'picture hangers', 'nails']

  def affix_with
    puts "We suggest hanging this piece with #{MOUNTING.sample}."
  end
end

class Transaction
  include Displayable

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
  include Hangable

  attr_reader :artist, :title, :date

  def initialize(artist, title, date)
    @artist = artist
    @title = title
    @date = date
  end

  def to_s
    "#{artist}, #{title}, #{date}. #{medium.capitalize}."
  end
end

class Painting < Artwork
  attr_reader :medium

  def initialize(artist, title, date)
    super
    @medium = 'oil on canvas'
  end
end

class Photograph < Artwork
  attr_reader :medium

  def initialize(artist, title, date)
    super
    @medium = 'gelatin silver print'
  end
end

class Artist
  attr_reader :name, :birth, :death

  def initialize(name, birth, death = nil)
    @name = name
    @birth = birth
    @death = death
  end
end

john_grey = Client.new('John Grey')
satya_james = Client.new('Satya James')
john_grey.interests = ['Group f64', 'Modernism', 'FSA']

sale1 = Transaction.new(john_grey)
sale2 = Transaction.new(satya_james)
p sale1
p sale2
puts Transaction.total_transactions

edward_weston = Artist.new('Edward Weston', 1886, 1958)
vincent_van_gogh = Artist.new('Vincent van Gogh', 1853, 1890)
rae_davis = Artist.new('Rae Davis', 1970)
p edward_weston
p vincent_van_gogh
p rae_davis

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.affix_with
