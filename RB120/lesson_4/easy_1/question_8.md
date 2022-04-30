```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

The `self` literal within the `make_one_year_older` instance method refers to the `Cat` object that this method was called on. In this example we are actually using both the setter and getter method for `age` as ruby is converting the body of `make_one_year_older` from:
```ruby
self.age += 1
```

into:

```ruby
self.age = self.age + 1
```
