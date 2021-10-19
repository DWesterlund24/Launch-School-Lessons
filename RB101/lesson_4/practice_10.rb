# The return value will be [1, nil, nil].
# When the number in this block is greater than 1, the Kernel#puts method is run.
# Kernel#puts always returns nil.
# When the number in this block is not greater than 1, the number itself is declared.

# Array#map then returns an array of these returns resulting in [1, nil, nil]
