# problem6.rb - Question 6

# If we have these two methods:
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and
class ComputerToo
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    # self.template
    template
  end
end

# What is the difference in the way the code works?

# 1. in the first we directly set the instance variable template to the given
# string while in the second we use the setter method to do so.
# 2. in both cases we access the getter method in show_template, though in the
# second case we do so more explicitly (redundantly) by prefixing self
