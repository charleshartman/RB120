# method_access_control_ex3.rb

class HighScore
  include Comparable

  def initialize(score)
    @score = score
  end

  def <=>(other)
    score <=> other.score
  end

  protected

  attr_reader :score
end

lizzie_score = HighScore.new(28736)
lulu_score = HighScore.new(56732)

if lizzie_score > lulu_score
  puts "Lizzie has the highest score."
elsif lulu_score > lizzie_score
  puts "Lulu has the highest score."
end
# => Lulu has the highest score.
