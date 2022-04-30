## Case 1
The `hi` method is called on the `Hello` object `hello`, Ruby finds this in the `Hello` class definition where the `greet` method is invoked with `"Hello"` as its argument. Ruby finds the `greet` method in the superclass of `Hello` because there was no `greet` method within that class definition. the `puts` method is then called, which is found in the `Kernel` module, because Ruby failed to find `puts` in the `Hello` class definition, the `Greeting` class definition, and the `Object` class definition, so it searched in the included module within the `Object` class and resolved the invocation using that method. In case 1, the string `"Hello"` will be printed to the terminal.

## Case 2
This code will produce a NoMethodException. The `hello` variable points to a `Hello` object. There is no `bye` method within the `Hello` class definition nor any of its modules or any superclasses of the `Hello` class nor any of their modules. Since Ruby cannot find the method we invoked, it returns an Exception.

## Case 3
This code will produce an exception. The error will tell us that the `greet` method expected 1 argument but recieved 0 arguments.

## Case 4
This code will print `"Goodbye"` to the terminal. The Hello object has access to the `greet` method because it inherits from the `Greeting` class.

## Case 5
This will produce an exception. We are invoking a *class* method here and we have not defined any class methods in `Hello` or any of its superclasses or any modules.
