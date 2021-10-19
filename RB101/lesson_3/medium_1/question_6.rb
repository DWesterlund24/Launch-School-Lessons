# The output should be: 34
# We are printing answer here, the method's return is assigned to new_answer.

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8