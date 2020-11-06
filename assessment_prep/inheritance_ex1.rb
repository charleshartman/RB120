# inheritance_ex1.rb

module Hangable
  MOUNTING = ['a cleat', 'picture hangers', 'nails']

  def affix_with
    puts "We suggest hanging this piece with #{MOUNTING.sample}."
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

van_gogh = Painting.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh
van_gogh.affix_with
