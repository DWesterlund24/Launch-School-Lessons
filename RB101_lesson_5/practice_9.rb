# Solution 1
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.each do |sub_arr|
  sub_arr.sort! { |a,b| b <=> a }
end

p arr

# Solution 2
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map! do |sub_arr|
  sub_arr.sort { |a,b| b <=> a }
end

p arr
