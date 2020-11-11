# duck_typing_ex2.rb

class Cutting
  def knife(workers)
    workers.each(&:cut)
  end
end

class Logger
  def cut
    puts "I am slicing the logs! Timberrrr!"
  end
end

class Chef
  def cut
    puts "Chopping these onions is making me cry."
  end
end

class Seamstress
  def cut
    puts "I use very sharp scissors to cut my thread."
  end
end

Cutting.new.knife([Logger.new, Chef.new, Seamstress.new])
