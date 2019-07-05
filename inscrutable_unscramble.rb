### USER UNSCRAMBLING METHOD ###

def unscramble
  moves_left = 4
      4.times do
          puts ""
          puts "        ################"
          puts "        #{moves_left} MOVES REMAIN..."
          puts "        ################"
          puts ""
          display_board()
          puts ""
          puts "                   which transformation would you like to use?"
          display_options()

          loop do
            puts "#######"
            user_response = gets.chomp
            puts "#######"

            #jump
            if user_response == "1"
              puts "                  Choose the left-most piece you want to jump"
              start_piece = gets.chomp.to_i
              puts "                  Choose up to three total pieces to move"
              pieces_moved = gets.chomp.to_i
              puts "                  Choose the direction of your jump ('-1' for Left // '1' for Right)"
              direction = gets.chomp.to_i
              puts "                  Choose how many spaces you want to jump."
              jump_spaces = gets.chomp.to_i
              sleep(1)
              jump(start_piece, pieces_moved, direction, jump_spaces)
              break

              #shift
            elsif user_response == "2"

              puts "                  Which direction would you like to shift? ('-1' for Left // '1' for Right)"
              direction = gets.chomp.to_i
              puts "                  How many spaces do you want to shift?"
              spaces = gets.chomp.to_i
              shift(direction, spaces)
              sleep(1)
              break

              #reverse
            elsif user_response == "3"

              sleep(1)
              reverse()
              break

              #swap
            elsif user_response == "4"

              puts "                   Choose a first piece to swap with."
              piece_1 = gets.chomp.to_i
              puts "                   Choose a second piece to swap with."
              piece_2 = gets.chomp.to_i
              sleep(1)
              single_swap(piece_1, piece_2)
              break

            else
              puts "                   that's not a valid option. Try again:"
            end
          end

          $current_board.delete_if {|el| el == nil}

          if $current_board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
            break
          end
          moves_left -= 1
      end

          if $current_board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
            $win_loss[:wins] += 1
            $finish = Time.now
            $points = $finish - $start
            puts "You took this long: #{$points}"
            display_final_message("WIN")
          else
            $win_loss[:losses] += 1
            $finish = Time.now
            $points = $finish - $start
            puts "You took this long: #{$points} seconds."
            display_final_message("LOSE")
          end
end
