# The return value will be {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}.
# We've declared the object that we're returning to be a hash by placing it as
# the argument to Enumerable#each_with_object. In the block we are assigning the
# the key of our new hash as the first character in the string of each element.
# Then we are assigning the value of that element as the value of that key.
