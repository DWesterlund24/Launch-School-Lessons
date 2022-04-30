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

If we did want to use the `self` prefix on line 10 for some reasons, we could instead access the instance variable directly by typing `@age += 1`.
