# classes_objects.rb

class ArtWork
  def initialize(artist, title, date)
    @artist = artist
    @title = title
    @date = date
  end
end

van_gogh = ArtWork.new('Vincent van Gogh', 'The Starry Night', 1889)
puts van_gogh # => #<ArtWork:0x00007fe3f88400b0> (encoding may differ)

weston = ArtWork.new('Edward Weston', 'Pepper No. 30', 1930)
puts weston # => #<ArtWork:0x00007fca45833cb0> (encoding may differ)

# puts van_gogh.name # <== will return NoMethodError as we have no getter
