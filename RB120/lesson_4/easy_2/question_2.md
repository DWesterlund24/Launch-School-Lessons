```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future
```

This will output one of the following strings at random:

- "You will visit Vegas"
- "You will fly to Fiji"
- "You will romp in Rome"

Just like in the last example, the `choices` invocation within the `predict_the_future` instance method is called on the calling object of the `predict_the_future` method. So even though the `predict_the_future` instance method is defined within the `Oracle` class, it is our `RoadTrip` object that the `predict_the_future` method was called upon, and so ruby will look within the `RoadTrip` class before searching anywhere else for a `choices` method and that is the one it will find and resolves.
