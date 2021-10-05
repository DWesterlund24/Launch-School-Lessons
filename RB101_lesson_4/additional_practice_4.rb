# Solution 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
lowest = nil

ages.size.times do |count|
  lowest = ages.values[count] if count == 0 || ages.values[count] < lowest
end

p lowest

# Solution 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
lowest = 0

loop do
  break if ages.value?(lowest)
  lowest += 1
end

p lowest

# Solution 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
lowest = ages.values.sort[0]

p lowest

# Solution 4
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
lowest = ages.values.min

p lowest

# My thought after solution 1 was that there had to be a better way to do this. So after thinking I thought
# solution 2 would be a fun different way to do it, though likely unpractical. I then though to sort them
# and though that that was certaintly the best solution so far but wondered if there was a better one in the
# ruby documentation. So I went method hunting for solution 4 because I thought that something like that
# had to exist.
