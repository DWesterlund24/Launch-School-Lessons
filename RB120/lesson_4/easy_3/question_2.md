```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

If we call `Hello.hi` here we get an error message. `Hello.hi` is a class method invocation and we do not have a class method `hi`. So one way to fix this is to create a class method named `hi` by changing the `Hello` class definition this:

```ruby
class Hello < Greeting
  def self.hi
    greet("Hello")
  end

  def hi
    greet("Hello")
  end
end
```

This creates a class method that would have the same output that calling the `hi` method on `Hello` object would have, and the code in question would print `"Hello"`.
