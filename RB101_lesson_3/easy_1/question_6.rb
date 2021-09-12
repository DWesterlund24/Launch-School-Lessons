# Way 1
famous_words = "seven years ago..."

famous_words = "Four score and " + famous_words

puts famous_words

# Way 2
famous_words = "seven years ago..."

famous_words = "Four score and " << famous_words

puts famous_words

# Way 3
famous_words = "seven years ago..."

famous_words.insert(0, "Four score and ")

puts famous_words

# Way 4 
famous_words = "seven years ago..."

famous_words.prepend("Four score and ")

puts famous_words