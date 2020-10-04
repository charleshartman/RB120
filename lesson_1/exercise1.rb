# exercise1.rb

module EntWife
  def location(str)
    puts "#{str}"
  end
end


class TreeBeard
  include EntWife
end

oak = TreeBeard.new
oak.location('The Shire')

puts "---TreeBeard Ancestors---"
puts TreeBeard.ancestors
