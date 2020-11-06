# method_lookup_path_ex1.rb

module Displayable; end

module Collectible; end

class Client
  include Displayable
  include Collectible

  def initialize(name)
    @name = name
  end
end

puts Client.ancestors
