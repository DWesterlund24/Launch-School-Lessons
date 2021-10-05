# The return value here will be 11.
# The methods are going to run from left to right, first running the object through
# the first method, then running the returned value on the next, until there are no
# more methods in the chain.
# Here we are first using the Array#pop method which removes and returns the last
# value in the array. Because the returned value is the string, we are using
# String#size here, not Array#size. The length of the string is 11 characters,
# so that is what returns from this statement.
