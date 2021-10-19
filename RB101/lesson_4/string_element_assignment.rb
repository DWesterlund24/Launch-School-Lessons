str = "joe's favorite color is blue"
str[0] = 'J'
str # => "Joe's favorite color is blue"

str[str.index('favorite')] = 'F'
str[str.index('color')] = 'C'
str[str.index('is')] = 'I'
str[str.index('blue')] = 'B'

p str