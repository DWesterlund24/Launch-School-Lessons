```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

In this example, the `self` literal refers to the `Cat` class itself. We are in the scope of the class definition here, so when we use `self` within this scope, we are referring to the class itself. So the prepending `self` is basically saying, when this method is called on the class itself, this happens('this' referring to the body of the class method definiton).

When we don't prepend `self`, ruby assumes we are referring to an instance(object) of the class. So within an instance method definition, we change scope to that instance.

I'm not entirely sure if I've used the correct terminology when reffering to scope here, but this is how I interpret or visualize what is happening here.
