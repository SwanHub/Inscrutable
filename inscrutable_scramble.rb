### COMPUTER SCRAMBLING METHOD ###

def scramble

    methods = [method(:shift), method(:reverse), method(:single_swap), method(:jump)]

# Create denial of same-state logic check.
    board_states = []

    until board_states.length == 4

      method_choice = rand(1..4)

        if method_choice == 1
          #shift, 1 argument
          shift = [-8, -7, -6, -5, -4, -3, -2, -1, 1, 2, 3, 4, 5, 6, 7, 8].sample
          methods[0].call(shift)

        elsif method_choice == 2
          #reverse, no arguments
          methods[1].call

        elsif method_choice == 3
          #single_swap, 2 arguments
          piece1 = rand(1..9)
          piece2 = rand(1..9)
          methods[2].call(piece1, piece2)

        elsif method_choice == 4
          #jump, 3 arguments
          start_piece = rand(1..9)
          pieces_moved = rand(1..3)
          jump_movement_rand = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5].sample
          methods[3].call(start_piece, pieces_moved, jump_movement_rand)
        end #if

        board_states << $current_board
        board_states = board_states.uniq

    end #until

end #def
