# the (40 + 2) isn't being interpolated. A string can't be added to an integer
# and an integer can't be concatenated to a string. One way to fix this is to
# surround it in double quotation marks and use #{}. Like this "#{40 + 2}".

puts "the value of 40 + 2 is " + "#{40 + 2}"

# Another way to fix this is by using the Integer#to_s method on the
# bracketed 40 + 2, (40 + 2).to_s

puts "the value of 40 + 2 is " + (40 + 2).to_s