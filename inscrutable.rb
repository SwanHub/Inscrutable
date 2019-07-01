############ THE TIE-TOGETHER of the PROGRAM ############
require './inscrutable_methods.rb'
#require './inscrutable_scramble.rb'
#require './inscrutable_unscramble.rb'

### NOW FOR THE GAME FLOW ###

puts ""
puts ""
puts "            Welcome to the Game:"
puts ""
puts "            I N S C R U T A B L E "
puts ""
puts ""
puts "   Your OBJECTIVE is to unscramble the numbers"
puts "    and return them to their correct sequence."
puts ""
puts "        A winning sequence looks like this:"
puts "        1   2   3   4   5   6   7   8   9"
puts ""
puts ""
puts "          The RULES of engagemnent..."
puts "          You can only use THESE METHODS"
puts "          A Maximum of FOUR times:"
puts ""
puts "          1. Jump up to three pieces in either direction."
puts "          2. Shift the board in either direction."
puts "          3. Reverse the sequence."
puts "          4. Swap two pieces."

  display_board()

puts ""
puts "         When you are ready, type 'lets do this' below"
puts "         I will then scramble the board, making it INSCRUTABLE."

  #unscramble
