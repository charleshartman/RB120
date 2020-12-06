# example2.rb

# Constructors

class Interview
  def initialize(day_of_week)
    @day_of_week = day_of_week
  end
end

charles = Interview.new('Tuesday')
p charles
