arr = ['10', '11', '9', '7', '8']

p arr.sort { |a, b| b.to_i <=> a.to_i }

p arr.sort_by { |el| el.to_i }.reverse
