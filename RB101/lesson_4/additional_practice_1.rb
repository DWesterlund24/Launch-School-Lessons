# Solution 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}

flintstones.each_with_index { |name, index| flintstones_hash[name] = index }
p flintstones_hash

# Solution 2
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}

flintstones.size.times { |count| flintstones_hash[flintstones[count]] = count }
p flintstones_hash

# I prefer solution 1 because I find it more readable and to the point.
