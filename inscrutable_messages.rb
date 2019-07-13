### DISPLAY TEXT MESSAGES ###
require 'tty-prompt'

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
end

# Display transformation options.
def display_options
  puts ""
  puts "                1. Move a group of one, two or three in either direction."
  puts "                2. Shift the board in either direction."
  puts "                3. Swap two individual pieces."
  puts "                4. Reverse the sequence."
  puts ""
end

# Display win/loss message.
def display_final_message(msg)
  prompt = TTY::Prompt.new(symbols: {marker: '>'})
  failing_values = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    $current_board.each_with_index { |el, i|
      if el != i + 1
        failing_values[i] = "X"
      end
    }
    puts ""
    if msg == "LOSE"
      puts "                                        XXXXXXX"
      prompt.error("                                       YOU #{msg}!")
      puts "                                        XXXXXXX"
    elsif msg == "WIN"
      puts "                                        XXXXXXX"
      prompt.ok("                                       YOU #{msg}!")
      puts "                                        XXXXXXX"
    end
    puts ""
    display_board
    puts "                            #{failing_values[0]}   #{failing_values[1]}   #{failing_values[2]}   #{failing_values[3]}   #{failing_values[4]}   #{failing_values[5]}   #{failing_values[6]}   #{failing_values[7]}   #{failing_values[8]} "
    puts " "
    puts "                           Wins: #{$win_loss[:wins]}"
    puts "                           Losses: #{$win_loss[:losses]}"
    puts ""

end
