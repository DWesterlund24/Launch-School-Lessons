flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.push("Dino")
p flintstones

# or

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.append("Dino")
p flintstones

# or

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones << "Dino"
p flintstones

# or

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.concat(["Dino"])
p flintstones