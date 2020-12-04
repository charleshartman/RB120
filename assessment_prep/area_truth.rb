# area_truth.rb

class Area
  def self.square_units(length, width)
    if length > 0 && width > 0
      length * width
    end
  end
end

p Area.square_units(0, 36)
p Area.square_units(48, 65)
