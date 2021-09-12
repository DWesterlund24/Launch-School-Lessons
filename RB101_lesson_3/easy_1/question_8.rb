flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

# First try
barney = flintstones.select { |k, v| k == "Barney" }
array = barney.flatten

p array

# Second try
array = flintstones.rassoc(2)

p array

# Third try
array = flintstones.assoc("Barney")

p array