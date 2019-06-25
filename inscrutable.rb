############ WELCOME TO THE GAME: ################
################ INSCRUTABLE #####################

require 'pry'

# Plan:

## Create methods for each "move" a player or cpu can do...
## shift // jump // reverse // swap and their various forms... ()

## have the computer apply four of these moves to the ordered sequence in a
## randoml fashion.

## have the user choose one move at a time, while recording how many moves
## have been made.

## if the user gets the tiles all back in working order by move 4, then they win.
## if not, they can concede defeat and try again, concede defeat and quit,
## or concede defeat and continue until the game is over.

## I want to do some work with YIELD in this round. I also want to graduate
## from do...end and move into the more ubiquitous and professional realm of {}.
## I want this code to be written in 100 lines or less.

##########################################################################

# 1. Create the board. Let's make it an array. That will make it easier to
#   manipulate, since arrays are an ordered collection.

current_board = [4, 3, 2, 1, 5, 6, 7, 8, 9]
# indexes:      [0, 1, 2, 3, 4, 5, 6, 7, 8]

# 2. Create the methods.

# Display board works.
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

shift(current_board, 1, 6)

# [1, 2, 3, 4, 5, 6, 7, 8, 9]
# say I want to swap the 7 and the 3...

# integers relating to the index of the swapped pieces
def single_swap(piece_1, piece_2)

end

# simply use the .reverse function on the existing array.
def reverse
end

# not yet sure how this will work.
def jump(mobile_piece_number, mobile_piece_start_index, number_of_jumps, jump_direction)
end

# 3. Define method flow.
