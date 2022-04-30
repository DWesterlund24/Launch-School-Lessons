```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

The `@@cats_count` class variable keeps track of how many `Cat` objects have been instantiated. Before any code is run, the class definition is loaded into the system. When this happens, `@@cat_count` is set to 0. Every time we instantiate a new `Cat` object, `@@cats_count` is increased by 1. To check the current value of `@@cats_count`, we can call the `cats_count` class method. This will return the number of `Cat` objects that have been instantiated.

It would depend on the intention here, but if we intend to keep track of how many cat objects are in our code, we would have to be careful with this implementation, particularly if we create any duplicates. If we create a copy of one of our `Cat` objects using `#dup` or `#clone`, it is not the same as having two variables point to the same object, we have actually created a new `Cat` object and *bypassed* the constructor. If we bypass the constructor, our `@@cats_count` will *not* be incremented and we will have an inaccurate count of `Cat` objects.

I have demonstrated this in the `question_7.rb` file within this folder.
