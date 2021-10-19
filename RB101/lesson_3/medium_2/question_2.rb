=begin

Much of the situtation is the same here. Except the method is not using the
same variables. It's creating new variables for use inside the method wheras
the block does actually take the same variables.

In other words, the method is basically creating a new label to use for a value
it is recieving. Even though it might have the same name as a label outside
its scope, it is different, because a method always creates a new label for
its arguments.

So the variables from outside the method will not be changed here because no
destructive methods were called inside the method.

=end

# puts 1 -
  # before the block
  a_outer is 42 with an id of: 85 before the block.
  b_outer is forty two with an id of: 2152729580 before the block.
  c_outer is [42] with an id of: 2152729540 before the block.
  d_outer is 42 with an id of: 85 before the block.

  # before an_illustrative_method is called
  a_outer is 42 with an id of: 85 before the block.
  b_outer is forty two with an id of: 2152753560 before the block.
  c_outer is [42] with an id of: 2152753540 before the block.
  d_outer is 42 with an id of: 85 before the block.

# puts 2
  # inside the block
  a_outer id was 85 before the block and is: 85 inside the block.
  b_outer id was 2152729580 before the block and is: 2152729580 inside the block.
  c_outer id was 2152729540 before the block and is: 2152729540 inside the block.
  d_outer id was 85 before the block and is: 85 inside the block.

  # inside an_illustrative_method
  a_outer id was 85 before the method and is: 85 inside the method.
  b_outer id was 2152753560 before the method and is: 2152753560 inside the method.
  c_outer id was 2152753540 before the method and is: 2152753540 inside the method.
  d_outer id was 85 before the method and is: 85 inside the method.

# puts 3
  # inside the block
  a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
  b_outer inside after reassignment is thirty three with an id of: 2152729580 before and: 2152728320 after.
  c_outer inside after reassignment is [44] with an id of: 2152729540 before and: 2152728280 after.
  d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

  # inside an_illustrative_method
  a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
  b_outer inside after reassignment is thirty three with an id of: 2152753560 before and: 2152752300 after.
  c_outer inside after reassignment is [44] with an id of: 2152753540 before and: 2152752280 after.
  d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

# puts 4
  # inside the block
  a_inner is 22 with an id of: 45 inside the block (compared to 45 for outer).
  b_inner is thirty three with an id of: 2152728320 inside the block (compared to 2152728320 for outer).
  c_inner is [44] with an id of: 2152728280 inside the block (compared to 2152728280 for outer).
  d_inner is 44 with an id of: 89 inside the block (compared to 89 for outer).

  # inside an_illustrative_method
  a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer).
  b_inner is thirty three with an id of: 2152752300 inside the method (compared to 2152752300 for outer).
  c_inner is [44] with an id of: 2152752280 inside the method (compared to 2152752280 for outer).
  d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer).

# puts 5
  # after the block
  a_outer is 22 with an id of: 85 BEFORE and: 45 AFTER the block.
  b_outer is thirty three with an id of: 2152729580 BEFORE and: 2152728320 AFTER the block.
  c_outer is [44] with an id of: 2152729540 BEFORE and: 2152728280 AFTER the block.
  d_outer is 44 with an id of: 85 BEFORE and: 89 AFTER the block.
  (notice that each variable keeps its new object/object_id even when we leave the block.)

  # after an_illustrative_method
  a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
  b_outer is forty two with an id of: 2152753560 BEFORE and: 2152753560 AFTER the method call.
  c_outer is [42] with an id of: 2152753540 BEFORE and: 2152753540 AFTER the method call.
  d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.

# puts 6
  # after the block
  => "ugh ohhhhh"

  # after an_illustrative_method
  => "ugh ohhhhh"