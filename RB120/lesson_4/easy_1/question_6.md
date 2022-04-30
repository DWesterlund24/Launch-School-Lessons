```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

We can use `attr_accessor` for both setter and getter methods for the instance variable.

Or `attr_reader` and `attr_writer` for the getter and setter respectively.

These are keywords to be followed by a symbol with the same name as the instance variable but without the `@`. The respective methods will then be implemented automatically.

```ruby
class Cube
  attr_accessor :volume

  def initialize(volume)
    @volume = volume
  end
end
```
