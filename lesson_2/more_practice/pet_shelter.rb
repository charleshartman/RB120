# pet_shelter.rb
# Pet Shelter

class Pet
  attr_accessor :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_reader :name
  attr_accessor :pets, :number_of_pets

  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end
end

class Shelter
  @@clients = []

  def adopt(owner, pet)
    @@clients << owner if !@@clients.include?(owner)
    owner.pets << pet
    owner.number_of_pets += 1
  end

  def print_adoptions
    @@clients.each do |client|
      puts "#{client.name} has adopted the following pets:"
      client.pets.each do |pet|
        puts "a #{pet.type} named #{pet.name}"
      end
      puts
    end
  end
end

# Consider the following code:
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

=begin

Write the classes and methods that will be necessary to make this code run,
and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

The order of the output does not matter, so long as all of the information
is presented.

=end
