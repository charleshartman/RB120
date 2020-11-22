# polymorphism_ex1.rb

module Hangable
  def hang_with
    puts "We suggest hanging this piece with #{hardware}."
  end
end

class Artwork
  include Hangable

  attr_reader :artist, :title, :date, :medium

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
  def initialize(artist, title, date)
    super
    @medium = 'oil on canvas'
  end

  def hardware
    "picture hangers"
  end
end

class Photograph < Artwork
  def initialize(artist, title, date)
    super
    @medium = 'gelatin silver print'
  end

  def hardware
    "a cleat"
  end
end

weston = Photograph.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston
weston.hang_with
van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.hang_with
