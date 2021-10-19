# First solution
def color_valid(color)
  return true if color == "blue" || color == "green"
  false
end

# Second solution
def color_valid(color)
  color == "blue" || color == "green" ? true : false
end

# LS solution
def color_valid(color)
  color == "blue" || color == "green"
end

p color_valid("red")
p color_valid("blue")
p color_valid("green")