```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

The `manufacturer` method here is a class method, we know this because of the prepended literal `self`. `self` here refers to the class in question because we are in the scope of the class definition here. When we call a class method, the calling object is the class itself, not an instance of the class, so here it would be called like `Television.manufacturer`.

The `model` method here is an instance method. As it does not have the prepended literal `self`, it is assumed to be an instance method.
