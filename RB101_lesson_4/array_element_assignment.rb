arr = [1, 2, 3, 4, 5]
arr[0] += 1 # => 2
arr         # => [2, 2, 3, 4, 5]

arr[1] += 1
arr[2] += 1
arr[3] += 1
arr[4] += 1

count = 0
arr.length.times do
  arr[count] += 1
  count += 1
end

p arr