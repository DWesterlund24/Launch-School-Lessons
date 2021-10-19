def select_fruit(hsh)
  selected_items = {}
  keys = hsh.keys
  counter = 0

  loop do
    break if counter == hsh.size
    selected_items[keys[counter]] = 'Fruit' if hsh[keys[counter]] == 'Fruit'
    counter += 1
  end

  selected_items
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
