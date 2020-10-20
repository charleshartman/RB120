# ttt_computer_moves_logic.rb

def offensive_move(board)
  Board::WINNING_LINES.each do |line|
    if line.count { |num| board[num] == marker } == 2 &&
       line.count { |num| board[num] == ' ' } == 1
      return line.select { |num| board[num] == ' ' }.first
    end
  end
  nil
end

def defensive_move(board)
  Board::WINNING_LINES.each do |line|
    if line.count { |num| board[num] == marker } == 2 &&
       line.count { |num| board[num] == ' ' } == 1
      return line.select { |num| board[num] == ' ' }.first
    end
  end
  nil
end

=begin

[6] pry(#<Computer>)> line
=> [1, 2, 3]
[7] pry(#<Computer>)> line.count { |num| board[num] == 'X' }
=> 1
[8] pry(#<Computer>)> line.count { |num| board[num] == ' ' }
=> 2
[9] pry(#<Computer>)> line.select { |num| board[num] == ' ' }
=> [2, 3]
[10] pry(#<Computer>)> line.select { |num| board[num] == 'X' }
=> [1]
[11] pry(#<Computer>)> line.select { |num| board[num] == 'X' }.first
=> 1


[19] pry(#<Computer>)> self.marker
=> "O"

<-PEDAC->
problem:
  - find a line that has two computer markers present and one unmarked square
  - return the key for the unmarked square

input:  current board (hash) and WINNING_LINES constant (array of three element
        sub-arrays)
output: integer (key value)
data structure: array, hash, integer

algorithm:
  - iterate through WINNING_LINES
    - for each sub-array count the number of identical (marker) values that are
      present at the corresponding keys in current board
      - if there are two (computer)(marker)s present and one unmarked (" ")
        return the key value for the unmarked square

=end

