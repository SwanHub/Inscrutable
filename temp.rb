def mod(array)
new_array = []
  array.each_with_index {|a, i|
    new_array.push(array[(i+2)%9])
  }
  print new_array

end

mod([1, 2, 3, 4, 5, 6, 7, 8, 9])
#=>0 1 2 3 4 5 6 7 8 0 1

#Test of shift... using indexes.
