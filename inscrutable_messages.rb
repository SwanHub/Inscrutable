### DISPLAY TEXT MESSAGES ###

# Welcome msg.
def welcome

  puts ""
  puts ""
  puts "                                 Welcome to the Game:"
  puts ""
  puts "                                I N S C R U T A B L E "
  puts ""
  puts ""
  puts "                       Your OBJECTIVE is to unscramble the numbers"
  puts "                        and return them to their correct sequence"
  puts "                                    In Four Moves."
  puts ""
end

# Display board.
def display_board
  puts ""
  puts "                                   HERE IS THE BOARD: "
  puts ""
  puts "                ######################################################"
  puts "                Values: ### #{$current_board[0]}   #{$current_board[1]}   #{$current_board[2]}   #{$current_board[3]}   #{$current_board[4]}   #{$current_board[5]}   #{$current_board[6]}   #{$current_board[7]}   #{$current_board[8]} ########"
  puts "                ######################################################"
  puts ""
end

# Display transformation options.
def display_options
  puts ""
  puts "                1. Jump up to three pieces in either direction."
  puts "                2. Shift the board in either direction."
  puts "                3. Reverse the sequence."
  puts "                4. Swap two pieces."
  puts ""
end

# Display win/loss message.
def display_final_message(msg)
  puts ""
  puts "                                     ##########"
  puts "                                      YOU #{msg}!"
  puts "                                     ##########"
  puts ""
  display_board
  puts "                           Wins: #{$win_loss[:wins]}"
  puts "                           Losses: #{$win_loss[:losses]}"
  puts ""
end
