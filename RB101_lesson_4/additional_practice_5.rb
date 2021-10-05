# Solution 1
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

answer = nil
flintstones.each_with_index do |name, index|
  answer = index if name.start_with?('Be')
end

p answer

# Solution 2
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

answer = flintstones.index { |element| element.start_with?('Be') }

p answer
