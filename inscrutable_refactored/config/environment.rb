# why no: require 'rubygems' ?
require "bundler/setup"

require "sinatra/activerecord"
require 'ostruct'
require 'date'
require 'require_all'

require_all './app'

Bundler.require

# establishes connection to the database.
ActiveRecord::Base.establish_connection({adapter: 'sqlite3', database: 'db/inscrutable.db'})

# removes console logging to the terminal.
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

# clear screen
system("clear")

# new animation.
new_animation = Animation.new
system("clear")

new_animation.flatiron_title_animation
new_animation.games_title_animation
new_animation.vertical_tracer
new_animation.background_logo
sleep(5)

system("clear")

# welcome screen.
User.hello
# retrieve username.
username_input = gets.chomp
system("clear")
# find_or_create_by username input. Either way, set to 'user' placeholder.
user = User.user_new?(username_input)
# say hello to the user depending on if new or old... interpolation.
user.hello_again
## menu to choose between playing the game, seeing personal stats or general leaderboards
user.options_menu

# create new match associated with user:
match = user.new_match

##########CREATE NEW GAME LOOP (until keep_playing == false)
until match.keep_playing == false

  # create new game associated with this match.
  game = match.new_game
  # display the board in correct sequence.
  game.display_board

  # prompt user to see if they're ready to play...
  game.ready?

  # clear screen.
  system("clear")

  #########SCRAMBLE THE BOARD LOOP, until board states is kosher.
  board_states = [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
  until board_states.length == 5

    # create new move
    move = game.new_move
    # choose move type at random.
    movetype = move.choose_move_type

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

        # make sure there is no state duplication, then save changes.
        if !board_states.include?(changed_board)
          game.sync_board_state(changed_board)
          board_states << changed_board
        end

  end

  ############LOOOP THROUGH PLAYER MOVES...
  game.remaining_moves.times do
    # declare prompt.
    prompt = TTY::Prompt.new

    # display number of moves left.
    game.total_moves_remaining
    # display the newly scrambled board.
    game.display_board
    # display move options.
    game.display_options
    # create new move
    player_move = game.new_move
    # get a move choice from user.
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

        # save changes made to the board...
        game.sync_board_state(changed_board)
        # check for victory.
        if game.current_board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
          break
        end
        # de-increment moves remaining. Only relevant to "Moves remaining" display.
        game.remaining_moves -= 1

        # clear screen.
        system("clear")
        sleep(0.5)

  end

  system("clear")

  # check to see if the current_board matches the ideal board.
  game.check_for_victor
  # depending on the result in check_for_victor, display win or loss message.
  game.display_win_loss_message
  # display final board one last time.
  game.display_board
  # display incorrect board positions.
  game.incorrect_board_positions

  # display record overall...
  match.display_record
  # ask if they want to play again
  match.play_again?
  system("clear")

end

User.bye

############### END THE MATCH LOOP
