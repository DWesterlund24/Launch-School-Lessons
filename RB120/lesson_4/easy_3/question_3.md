```ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

To instantiate a new object, we can use the `::new` method appended to the name of the class. In this case we would need two arguments to pass in as well because we have to parameters in the constructor method `initialize`. We can make these whatever we would like.

```ruby
AngryCat.new(4, 'Felix')
AngryCat.new(5, 'Oliver')
```
