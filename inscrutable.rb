### OTHER FILES ###
require './inscrutable_transform_methods.rb'
require './inscrutable_scramble.rb'
require './inscrutable_unscramble.rb'
require './inscrutable_messages.rb'

### OPENER ###

welcome()
display_board()

### SCRAMBLE ###

while $play == true

  puts ""
  puts "                      When you are ready, type 'game on' below"
  puts "                I will then scramble the board, making it INSCRUTABLE."
  puts ""

    loop do
      puts "#######"
      user_response = gets.chomp
      puts "#######"
        if user_response == "game on"
          scramble
          $start = Time.now
          break
        elsif user_response == "bye"
          exit
        else
          puts "                 that's not a valid option. Press 'game on' to start."
          puts "                                   Or 'bye' to exit."
        end
    end

### USER UNSCRAMBLE ###

    unscramble()

### RESET/AGAIN? ###

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
