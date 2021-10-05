statement = "The Flintstones Rock"

occurence = Hash.new(0)
statement.chars.each { |char| occurence[char] += 1 unless char == ' '}

p occurence.sort.to_h
