```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future
```

This code will print one of the following strings at random:

- "You will eat a nice lunch"
- "You will take a nap soon"
- "You will stay at work late"

Within the `predict_the_future` instance method, when we invoke the `choices` method it is assumed that we are calling it on the calling object of *this* method. So it is the same as calling `self.choices.sample` but the `self` literal is unnecessary as ruby is already assuming this.
