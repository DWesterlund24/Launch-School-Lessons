```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

We can remove the `type` and `type=` methods here and either add:

```ruby
attr_accessor :type
```

We could also have done this instead:

```ruby
attr_reader :type
attr_writer :type
```

But the former is more succinct and more preffered.
