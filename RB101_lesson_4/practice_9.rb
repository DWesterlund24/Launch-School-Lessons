# Enumerable#map takes the first value looks at the first line, and does
# not meet the criteria in the if statemen. So in this iteration, the if statement was the last
# line run, returning a value of nil.
# On the next iteration, the value does meet the criteria of the if statement and so it takes the return
# from the last line of the if statemnt which is value.
# Enumeragle#map returns these as an array, [nil, "bear"].
