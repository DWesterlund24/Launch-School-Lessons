ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# The four below all do the same thing.
puts ages.include?("Spot")
puts ages.key?("Spot")
puts ages.has_key?("Spot")
puts ages.member?("Spot")
