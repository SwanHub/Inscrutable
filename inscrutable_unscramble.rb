### WHERE WE DEFINE THE UNSCRAMBLING METHOD OF THE COMPUTER ###


#--after the scrambling has occurred
#-LOOP
#---ask user which transform method they want to use
#----if 1, ask for direction and amount
#-----if 2, no arguments needed
#------if 3, ask for two pieces
#-------if 4, ask for direction, count, start_piece and pieces_moved.
#-Loop through this process 4 times...
#--------at the end of each loop, delete any "nil" if they've appeared.
#---------then check to see if their sequence resulted in a successful sequence.
#----------if it has, then let them know they won, and keep track of their w/l
#-----------if not, then give them option to try again from scratch or on the
#------------same scramble once more.
