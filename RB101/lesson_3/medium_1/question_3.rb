def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Bonus 1
# the purpose of number % divisor == 0 is to see if the number is divisible
# by the divisor.

# Bonus 2
# In the second to last line we are returning the array factors. Ruby always
# returns the result of the last line of the expression, unless return is 
# explicitly used earlier.