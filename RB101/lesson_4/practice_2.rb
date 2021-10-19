# How we can find out what a method does should be simple, look at the documentation.
# Though I suppose what might be less simple, is where you find that method in the
# documentation. It could either be under the class you are working with, in the
# parent of that class, or in a module accessible by that class. In this case it is
# in the class we are working with.

# Array#count will only count the value if it meets the criteria in the block
# In this case, 'ant' and 'bat' are the only values to meet the criteria.
# Array#count then returns the amount of values that met the criteria, in this case 2.
