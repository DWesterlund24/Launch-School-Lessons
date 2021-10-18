require "pry-byebug"

def find_anagrams(word, array)
  array.each_with_object([word]) do |word2, anagram_list|
    anagram_list << word2 if word.chars.sort == word2.chars.sort
  end
end

def anagrams(words)
  results = []
  words.each_with_index do |word, index|
    next if results.flatten.include?(word)

    results << find_anagrams(word, words[(index + 1)..])
    binding.pry
  end
  results.each { |sub_array| p sub_array }
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide', 'art',
  'flow', 'neon', 'tar', 'rat', 'ha', 'ah', 'ready', 'deary']

anagrams(words)
