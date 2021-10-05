def double_odd_index(numbers)
  counter = 0
  new_numbers = []

  loop do
    break if counter == numbers.size

    new_numbers << (counter.odd? ? numbers[counter] * 2 : numbers[counter])

    counter += 1
  end
  new_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p my_numbers
p double_odd_index(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers
