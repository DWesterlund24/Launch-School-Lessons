def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# In the first example the original input will also be changed.
# So if the user needed to still keep the original input as well as the ouput,
# the second example would be better.

# rolling_buffer1 has side effects and a return value whereas rolling_buffer2
# does not have side effects and is simply used to get the return value.
# rolling_buffer1 might have unintended consequences for the user.