# Solution 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.reject { |_, v| v > 100 }
p ages

# Solution 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

too_old, ages = ages.partition { |_, v| v > 100 }
ages = ages.to_h
too_old =  too_old.to_h
p ages

# Solution 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.delete_if { |_, v| v > 100}
p ages

# Solution 3 is the closest to what was asked, it is simply removing anything with a value over 100.
# Solution 1 is a good alternative if we want to preserve the original hash.
# Solution 2 can be used to split the hash in case we also want to do something with the values over 100.
