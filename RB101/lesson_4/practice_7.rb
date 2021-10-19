# The block's return value will be either true or false because that is what Integer#odd? returns.
# Integer#odd? will return true if the integer is not divisible by 2. Else it will return false.
# Because at least one of these values returns a truthy value, Array#any? will return true.

# The side effect of this block is that it will also print each number in the original array on a new line.
# However, once Array#any? finds a truthy value, it short circuits, so 1 is the only value that will be
# printed here.
