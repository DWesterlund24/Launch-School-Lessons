class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    "meow!"
  end
end

puts
puts "PROBLEM #1"

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
freddy = Bulldog.new
puts freddy.speak
puts freddy.swim


puts
puts "PROBLEM #2"

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

puts
puts "PROBLEM #3"

puts "
       +------+
       | Pet  |
       |------|
       | run  |
       | jump |
       +------+
           |
    +------+------+
    |             |
+-------+     +-------+
|  Dog  |     |  Cat  |
|-------|     |-------|
| speak |     | speak |
| swim  |     +-------+
| fetch |
+-------+
    |
+---------+
| Bulldog |
|---------|
| swim    |
+---------+
"

puts ""
puts "POBLEM #4"
puts "The method lookup path is the order in which ruby searches for a method. For instance, if we called the `run` isntance method on a `Bulldog`` object here, ruby would first search for the `run` method within the `Bulldog` class definition. If it had found it there, it would call that method. In this case there is no method named `run` there so ruby will continue searching. If there were any modules included in the `Bulldog` class definition, it would search those next. It then moves on to the superclass and repeats the same process. Search the class definition, then any modules. and then it would proceed to the next superclass and repeat the process again until finally it searches through the BasicObject class, at which point there are no more superclasses to search. In this particular example, ruby would find `run` in the `Pet` class definition and stop searching there, invoking that instance method."
