# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []


# input: string
# output: string
# rules:
#      Explicit requirements:
#       - return all substrings that are palindromes
#       - palindromes are case sensitive. ('abA' is not a palindrome, 'aba' is.)

#      Implicit requirements:
#       - return should be an array
#       - palindromes can exist within other palindromes
#       - if there are no palindromes, return an empty array
#       - if the string is an empty string, return an empty array