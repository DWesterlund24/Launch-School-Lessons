```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

An instance variable begins with the `@` character, so it is clear here that the `Pizza` class is setting an instance variable; the instance variable `@name`.
