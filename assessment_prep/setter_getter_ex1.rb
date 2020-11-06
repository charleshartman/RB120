# setter_getter_ex1.rb

class Artwork
  attr_accessor :artist, :title, :date
end

van_gogh = Artwork.new
van_gogh.artist = 'Vincent van Gogh'
van_gogh.title = 'The Starry Night'
van_gogh.date = 1911

puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"

van_gogh.date = 1889
puts "Corrected:\n"
puts "#{van_gogh.artist}, #{van_gogh.title}, #{van_gogh.date}"
