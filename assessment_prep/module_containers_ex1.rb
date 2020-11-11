# module_containers_ex1.rb

module Consolable
  def self.prompt_purple(msg)
    puts "\e[34m#{msg}\e[0m"
  end
end

Consolable.prompt_purple("This method doesn't fit elsewhere.")
