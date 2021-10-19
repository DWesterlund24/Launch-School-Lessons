# First solution
10.times { |time| puts (' ' * time) + "The Flinstones Rock!" }

# Second solution
10.times { |time| puts "The Flinstones Rock!".prepend(' ' * time) }