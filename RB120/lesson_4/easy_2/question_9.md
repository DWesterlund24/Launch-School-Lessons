```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

If we add a `play` method to the `Bingo` class definition, there would no longer be much of a reason for it to inherit from `Game` as `Game` isn't giving us anything new, unless the `super` keyword is used within the new `play` definnition. `super` yields to the superclass method of the same name. This is used to add functionality to a previously defined method that exists within a superclass. Ruby looks first within the calling class and then moves to modules and superclass in its method search. So the `play` method within `Bingo` is the one that would be resolved when `play` is invoked on a `Bingo` object.
