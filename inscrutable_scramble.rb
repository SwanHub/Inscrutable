### COMPUTER SCRAMBLING METHOD ###

def scramble

    array_of_methods = [method(:shift), method(:reverse), method(:single_swap), method(:jump)]

    4.times do

      method_choice = rand(1..4)

        if method_choice == 1
          #shift, 2 arguments
          direction = [-1, 1].sample
          count = rand(1..8)
          array_of_methods[0].call(direction, count)

        elsif method_choice == 2
          #reverse, no arguments
          array_of_methods[1].call

        elsif method_choice == 3
          #single_swap, 2 arguments
          piece1 = rand(1..9)
          piece2 = rand(1..9)
          array_of_methods[2].call(piece1, piece2)

          #right now only using preventative for "nil" pop-ups. Not @ root cause.

        elsif method_choice == 4
          #jump, 4 arguments
          start_piece = rand(1..9)
          pieces_moved = rand(1..3)
          spaces_jumped = rand(1..5)
          direction = [-1, 1].sample
          array_of_methods[3].call(start_piece, pieces_moved, spaces_jumped, direction)
        end
        $current_board.delete_if {|el| el == nil }
    end
end
