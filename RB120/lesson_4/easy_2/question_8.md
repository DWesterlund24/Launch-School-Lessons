```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo
  def rules_of_play
    #rules of play
  end
end
```

To have the `Bingo` class inherit from the `Game` class, We can append the class name with ` < Game`. A less than symbol followed by the class that we want to be the superclass. The `Bingo` class should then look like this:

```ruby
class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```
