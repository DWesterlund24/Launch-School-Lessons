# How we can find out what a method does should be simple, look at the documentation.
# Though I suppose what might be less simple, is where you find that method in the
# documentation. It could either be under the class you are working with, in the
# parent of that class, or in a module accessible by that class. In this case it is
# in the class we are working with.

# Array#first takes the first value it finds if there is no argument and takes the
# first x number of values it finds if there is an argument, with x being the integer
# used as the argument. Array#take does the same thing but with one major difference,
# it will pass over any value that is not a non-negative integer.

# So in this case, it will return [1, 2]
# This method is not destructive
