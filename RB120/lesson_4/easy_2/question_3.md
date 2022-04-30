```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

In this example, if we calling a method on an `Orange` object, Ruby will search in this order:

    Orange => Taste => Object => Kernel => BasicObject

And for `HotSauce` it is very similiar.

    HotSauce => Taste => Object => Kernel => BasicObject

When we create a class definition, that class inherits from the `Object` class automatically. The `Object` class includes the `Kernel` module and inherits from the `BasicObject` class. When a method is called on an object, Ruby first checks the class of the calling object, then proceeds to any modules included in that class beginning with the last one to be included to the first. It then proceeds to the superclass checks there, and then the modules included in that superclass again starting with the last module to be included to the first. Ruby repeats this process until there are no more superclasses to proceed to, and no more included modules to check.

This can be confirmed by calling the `::ancestors` method on a class.
