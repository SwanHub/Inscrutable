def play_game
  #setup prompts w gem 'tty-prompt'
  prompt = TTY::Prompt.new
  system("clear")

  ###################################################################

  # introduction animation
  new_animation = Animation.new
  new_animation.intro_animation_sequence

  # welcome screen // user sign-in
  User.hello
  username = prompt.ask("username:", active_color: :red)
  system("clear")
  user = User.find_or_create_by(name: username)
  user.hello_again
  user.options_menu

  # new match, associated with user:
  match = user.new_match

  ##### NEW GAME, within MATCH --------------------------------------
  until match.keep_playing == false

        game = match.new_game
        game.display_board
        game.ready?
        system("clear")

       ###### SCRAMBLE BOARD ----------------------------------------
        board_states = [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
        until board_states.length == 5

              move = game.new_move
              movetype = move.choose_random_move_type

              if movetype == "shift"
                 shift_amount = [1, 2, 3, 4, 5, 6, 7, 8].sample
                 changed_board = move.shift(shift_amount)

              elsif movetype == "reverse"
                    changed_board = move.reverse

              elsif movetype == "swap"
                    piece_1 = rand(1..9)
                    piece_2 = rand(1..9)
                    changed_board = move.swap(piece_1, piece_2)

              elsif movetype == "jump"
                    start_piece = rand(1..9)
                    pieces_moved = rand(1..3)
                    jump_movement = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5].sample
                    changed_board = move.jump(start_piece, pieces_moved, jump_movement)
              end

              # ensure no state duplication, save.
              if !board_states.include?(changed_board)
                 game.sync_board_state(changed_board)
                 board_states << changed_board
              end
    end

    #### PLAYER MOVES, loop -----------------------------------------
    game.remaining_moves.times do
         game.total_moves_remaining
         game.display_board
         game.display_options
         player_move = game.new_move
         move_type = game.which_move_type?

         if move_type == 1
            start_piece = prompt.ask("Choose the left-most piece you want to move", active_color: :cyan).to_i
            pieces_moved = prompt.ask("Choose up to three total pieces to move", active_color: :cyan).to_i
            jump_movement = prompt.ask("Declare your jump ('-3' for 3 spaces L | '4' for 4 spaces R)", active_color: :cyan).to_i
            changed_board = player_move.jump(start_piece, pieces_moved, jump_movement)

         elsif move_type == 2
               shift_movement = prompt.ask("Declare your shift ('-3' is 3 moves L | '5' is 5 moves R)", active_color: :cyan).to_i
               changed_board = player_move.shift(shift_movement)

         elsif move_type == 3
               piece_1 = prompt.ask("Choose the first piece to swap.", active_color: :cyan).to_i
               piece_2 = prompt.ask("Choose the second piece to swap.", active_color: :cyan).to_i
               changed_board = player_move.swap(piece_1, piece_2)

         elsif move_type == 4
               changed_board = player_move.reverse
         end

         # save board changes & quick check for victory
         game.sync_board_state(changed_board)
         if game.current_board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
           break
         end
         game.remaining_moves -= 1
         system("clear")
         sleep(0.5)
    end

    #### GAME OVER PROMPTS ------------------------------------------
    system("clear")
    game.check_for_victor
    game.display_win_loss_message
    game.display_board
    game.incorrect_board_positions

    match.display_record
    match.play_again?
    system("clear")

  end ### MATCH LOOP ENDS, SESSION OVER -----------------------------

  User.bye
end
