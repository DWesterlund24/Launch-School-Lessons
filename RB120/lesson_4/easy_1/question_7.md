To find this we can look at the documentation for `Object`.
If it is not there, we can check `BasicObject` or the `Kernel` module, as the `Object` class includes the `Kernel` module and inherits from the `BasicObject` class.

It is in fact in the `Object` class documentation though, and we can see there that `to_s` will print the object's class and an encoding of the object id by default.
