```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
```

```ruby
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
```

Both these examples achieve the same goal, but both have unnecessary components.

In the first example, we have an `attr_accessor` for `@template`, but we only use the getter method and assign the instance variable directly within the `create_template` method.

In the second example, we prepend both `self` when we call both the setter and the getter methods for `@template`. We really only need to use this for the setter method so the prepended `self.` literal within the `show_template` method is unnecesary here.

I think the preferred way to write this would be like this:

```ruby
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    template
  end
end
```
