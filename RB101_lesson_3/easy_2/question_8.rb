advice = "Few things in life are as important as house training your pet dinosaur."
p advice.slice!(0, advice.index('house'))
p advice

# If we use #slice instead, the same string would be returned but the original string would be untouched.
# String#slice is an alias for String#[]