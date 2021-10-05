# Solution 1
arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr2 = arr.map do |hsh|
  hsh = hsh.map do |pair|
    pair[1] += 1
    pair
  end
  hsh.to_h
end

p arr2

# LS Solution
arr2 = arr.map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end

p arr2
