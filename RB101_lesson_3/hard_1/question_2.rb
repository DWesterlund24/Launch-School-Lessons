# I expect that it will print {:a=>"hi there"}.
# String#<< mutates the object it is called on.
# In this case the object is the value referenced by the symbol :a in the hash greetings.

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings