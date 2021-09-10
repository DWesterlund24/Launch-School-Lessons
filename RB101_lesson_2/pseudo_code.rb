=begin
1

Casual pseudo-code

Ask user for a number.
If invalid, re-ask user for number.
Ask user for another number.
If invalid, re-ask user for number.
Add two numbers and return result.

Formal pseudo-code

START

LOOP
  GET number_1
  IF number_1
    BREAK

LOOP
  GET number_2
  IF number_2
    BREAK

result = number_1 + number_2
RETURN result

END


2

Casual pseudo-code

Recieve an array
Iterate over array taking each string and adding it to the end of new variable result
return the result

Formal pseudo-code

START

GET array
SET result = ""

WHILE iterator < array length
  SET result = result + string at space "iterator" of array 
  iterator = iterator + 1

RETURN result

END


3

Casual pseudo-code

Recieve an array
Iterate over array and select only if index number is odd
return new array

Formal pseudo-code

START

GET array

new_array = WHILE iterator < array length
              SELECT integer if iterator is not divisible by 2
              iterator = iterator + 1

RETURN new_aray

END






