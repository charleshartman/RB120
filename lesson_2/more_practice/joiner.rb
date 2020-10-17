# joiner.rb

def joinor(keys)
  return keys.first.to_s if keys.size == 1
  (keys[0..-2].join(', ')) + ' or ' + keys.last.to_s
end

p joinor([1])                      # => "1"
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
