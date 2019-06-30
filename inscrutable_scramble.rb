### WHERE WE DEFINE THE SCRAMBLING METHOD OF THE COMPUTER ###

require './inscrutable_methods.rb'
#require './inscrutable.rb'

def shift_method
  shift(-1, rand(1..8))
end

odd_array = [method(:shift_method)]

#this works.
odd_array[0].call

[-1, 1].sample #chooses one or the other form -1 or 1... probably the way to go
rand(-1..1) #then figure out a way to remove 0 as an option.
