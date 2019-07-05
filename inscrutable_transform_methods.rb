
# Global Variables.
$current_board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
$win_loss = {wins: 0, losses: 0}
$play = true
$start = 0
$finish = 0
$points = 0

# shift_direction :: -1 or +1, rep R or L. shift_count defines # of places moved.
def shift(shift_direction, shift_count)
  new_array = []
  $current_board.each_with_index do |el, i|
      new_array.push($current_board[(i - (shift_count*shift_direction))%9])
    end
    $current_board = new_array
end

# simply use the .reverse function on the existing array.
def reverse
  $current_board.reverse!
end

# integers relating to the index of the swapped pieces
def single_swap(piece_1, piece_2)
  index_1 = $current_board.index(piece_1)
  index_2 = $current_board.index(piece_2)
  $current_board[index_1] = piece_2
  $current_board[index_2] = piece_1
end

# Number or adjacent numbers jump L or R by X places.
def jump(starting_piece, num_pieces_moved, jump_direction, number_of_jumps)
  starting_index = $current_board.index(starting_piece)
  slice_of_array = $current_board.slice!(starting_index, num_pieces_moved)
  new_index = starting_index + (number_of_jumps*jump_direction)
    # correcting for negative index notation.
    if new_index < 0
      new_index -= 1
    end
  $current_board.insert(new_index, slice_of_array)
  $current_board.flatten!
end
