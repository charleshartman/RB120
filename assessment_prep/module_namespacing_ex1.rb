# module_namespacing_ex1.rb

module Creatures
  class Arachnid
    def legs
      puts "I have eight legs."
    end
  end

  class Raccoon
    def paws 
      puts "I have four paws."
    end
  end

  class Zombie
    def feet
      puts "I have ACK!.... BRAINS.... two feet?"
    end
  end
end

Creatures::Zombie.new.feet
Creatures::Raccoon.new.paws
Creatures::Arachnid.new.legs
