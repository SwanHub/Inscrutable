require 'pry'

############ WELCOME TO THE GAME: ################
################ INSCRUTABLE #####################

current_board = [4, 3, 2, 1, 5, 6, 7, 8, 9]
# indexes:      [0, 1, 2, 3, 4, 5, 6, 7, 8]

# Display board.
def display_board(array)
  array.map! do |el|
    el += 1
  end
  print array
end

# DONE
# shift_direction :: -1 or +1, rep R or L. shift_count defines # of places moved.
def shift(current_board, shift_direction, shift_count)
  new_array = []
  current_board.each_with_index do |el, i|
      new_array.push(current_board[(i - (shift_count*shift_direction))%9])
    end
    print new_array
end

# DONE
# simply use the .reverse function on the existing array.
def reverse(current_board)
  current_board.reverse!
  print current_board
end

# integers relating to the index of the swapped pieces
def single_swap(current_board, piece_1, piece_2)
  #Algorithm: - save piece_1 index...
            # - save piece_1 value...
            # - save piece_2 index...
            # - save piece_2 value...
            # - set piece_1 index to piece 2 value...
            # - set piece_2 index to piece 1 value...

end

def jump(mobile_piece_number, mobile_piece_start_index, number_of_jumps, jump_direction)
  # Algorithm: - save the piece indexes...
            #  - save the piece value...
            #  - create an array of those pieces using .slice!...
            #  - .insert the array at the piece index -+ jump_number, depending.
            #  - flatten the array.

end

# 3. Define method flow.
