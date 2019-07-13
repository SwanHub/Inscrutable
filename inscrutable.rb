### OTHER FILES ###
require './inscrutable_transform_methods.rb'
require './inscrutable_scramble.rb'
require './inscrutable_unscramble.rb'
require './inscrutable_messages.rb'
require 'tty-prompt'

prompt = TTY::Prompt.new

### OPENING MESSAGES ###

welcome()
display_board()

### COMP SCRAMBLES BOARD ###

while $play == true

  puts ""
  puts "                      When you are ready, choose 'play' below"
  puts "                I will then scramble the board, making it INSCRUTABLE."
  puts ""

    loop do
      user_response = prompt.select("ready?", %w(play leave), active_color: :cyan)
        if user_response == "play"
          scramble
          $start = Time.now
          break
        elsif user_response == "leave"
          exit
        end
    end

### USER UNSCRAMBLES, LOOP ###

    unscramble()

### RESET BOARD / PLAY AGAIN PROMPT ###

$current_board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
$start = 0
$finish = 0
$points = 0

    puts "Do you want to play again? ('y' or 'n')"
    puts "#######"
    user_response = gets.chomp
    puts "#######"
    if user_response == "y"
      $play = true
    elsif user_response == "n"
      $play = false
    else
      puts "that's not a valid option. Press 'y' to continue. Or 'n' to exit."
    end

end
