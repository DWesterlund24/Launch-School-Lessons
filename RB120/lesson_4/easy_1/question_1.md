# Question

Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

1. true
2. "hello"
3. [1, 2, 3, "happy days"]
4. 142

# Answer

1. `true` is a `TrueClass` class object.
2. `"hello"` is a `String` class object
3. `[1, 2, 3, "happy days"]` is an `Array` class object
4. `142` is an `Integer` class object

This can be confirmed by calling the `Kernel#class` method on the object in question.
