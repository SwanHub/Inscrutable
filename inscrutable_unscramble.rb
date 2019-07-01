### WHERE WE DEFINE THE UNSCRAMBLING METHOD OF THE COMPUTER ###

## Will include a loop with user input...

def functionz(x, l)
  y = x + l + 1
  puts y
end

## THIS ALSO WORKS!!!!!

joy = [1, 2, 3].sample
jams = [-1, 1].sample

array = [method(:functionz)]
array[0].call(joy, jams)
