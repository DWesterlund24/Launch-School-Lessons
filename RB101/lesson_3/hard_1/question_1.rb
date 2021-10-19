# An undefined variable error

if false
  greeting = "hello world"
end

p greeting

# It is actually nil because it gets initialized as nil because the variable exists within the if block