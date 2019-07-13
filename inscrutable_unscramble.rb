### USER UNSCRAMBLING METHOD ###

def unscramble
  prompt = TTY::Prompt.new
  moves_left = 4
      4.times do
          puts ""
          puts "                                    ################"
          prompt.warn("                                    #{moves_left} MOVES REMAIN...")
          puts "                                    ################"
          puts ""

          display_board()
          display_options()

          puts ""
          user_response = prompt.ask("Which transformation would you like to use?").to_s
          puts ""

            #jump
            if user_response == "1"
                start_piece = prompt.ask("Choose the left-most piece you want to move").to_i
                pieces_moved = prompt.ask("Choose up to three total pieces to move").to_i
                jump_movement = prompt.ask("Declare your jump ('-3' for 3 spaces L | '4' for 4 spaces R)").to_i
              sleep(1)
              jump(start_piece, pieces_moved, jump_movement)

              #shift
            elsif user_response == "2"
              shift_movement = prompt.ask("Declare your shift ('-3' is 3 moves L | '5' is 5 moves R)").to_i
              shift(shift_movement)
              sleep(1)

              #swap
            elsif user_response == "3"
              piece_1 = prompt.ask("Choose the first piece to swap.").to_i
              piece_2 = prompt.ask("Choose the second piece to swap.").to_i
              sleep(1)
              single_swap(piece_1, piece_2)

              #reverse
            elsif user_response == "4"

              sleep(1)
              reverse()
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
            puts "You took: #{$points.round(2)} seconds."
            display_final_message("WIN")
          else
            $win_loss[:losses] += 1
            $finish = Time.now
            $points = $finish - $start
            puts "You took: #{$points.round(2)} seconds."
            display_final_message("LOSE")
          end
end
