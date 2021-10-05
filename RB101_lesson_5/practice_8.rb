hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each_value do |value|
  value.each do |string|
    string.each_char do |char|
      puts char if 'aeiou'.include?(char)
    end
  end
end
