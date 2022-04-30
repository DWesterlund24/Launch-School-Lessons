```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

If we want `to_s` to output `I am a tabby cat`, with `"tabby"` being a string object `@type` is pointing to, we could override the `to_s` definition by defining one within the `Cat` class definition.

```ruby
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end
```
