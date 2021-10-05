# The first example would print 1, then 3 on a new line.
# Each time after printing a number, the first index gets removed thus making every value
# one index lower. So when we take the second value, we are taking what was originally the
# third value because 2 was shifted over to the first slot.

# The second example would print 1, then 2 on a new line.
# Each time after printing a number, the last index gets removed. So after the second
# value, there are no more indices because we removed two from the end already.

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
