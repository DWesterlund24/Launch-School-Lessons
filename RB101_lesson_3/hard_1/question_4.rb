def is_an_ip_number?(number)
  number.to_i >= 0 && number.to_i <= 255
end

# Unaltered code
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break unless is_an_ip_number?(word)
  end
  return true
end

# First solution
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4

  dot_separated_words.each do |word|
    return false unless is_an_ip_number?(word)
  end

  true
end
