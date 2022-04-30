```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end
```

Presumably we are going to know that the object we are dealing with is a light already if we are calling a method named `light_status` on a `Light` boject. So it may be better to simply call it `status` instead.

We could alternatively make this a `to_s` method so when we call puts on the object we would get this information if we wanted to.
