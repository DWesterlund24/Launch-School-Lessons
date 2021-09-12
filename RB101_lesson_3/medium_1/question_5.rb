# limit cannot be accesed by fib() because it is outside of its scope.
# A method cannot access local variables outside its scope.


# One way to fix this would be to put declare limit inside the method.
def fib(first_num, second_num)
  limit = 15
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"


# The previous solution works fine, but what if we also need to use limit
# elsewhere? We could add limit as an argument to fib().
limit = 15

def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"


# A third way we could solve the problem is: If we know that limit will never
# need to be changed, we could make limit a constant. It would then be
# accessible from within methods. 
LIMIT = 15

def fib(first_num, second_num)
  while first_num + second_num < LIMIT
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"