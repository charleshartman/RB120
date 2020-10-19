# ttt_computer_moves_logic.rb

def []=(num, marker)
  @squares[num].marker = marker
end

def computer_moves
  mark = computer.center(board) || board.unmarked_keys.sample

  board.[]=(mark, computer.marker)
end

def two_identical_markers?(squares)
  markers = squares.select(&:marked?).collect(&:marker)
  return false if markers.size != 2
  markers.min == markers.max
end

def offensive(board)
  
end