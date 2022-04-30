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

If we run the following code,

```ruby
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```

The second line, `tv.manufacturer` would produce an error. We are calling an instance method `manufacturer` but we have only defined a *class* method manufacturer. If we did not encounter this error then we would get another error on line 6. Similiarly here we are calling the wrong type of method. We are calling a *class* method `model` when we have only defined an *instance* method `model`.
