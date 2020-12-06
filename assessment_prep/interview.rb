# interview.rb

module Questionable; end

class Interview
  include Questionable

  def initialize; end
  # additional implementation
end

class People; end

class TeachingAssistant < People; end
class Student < People; end

Interview.new # add constructor arguments after defining initialize
