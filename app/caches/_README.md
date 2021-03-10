# Caches

- Classes found here are used to encapsulate logic for Redis DB calls.
- The classes cache partials view
- On the folder base and partials you will find the parents/base classes.
- Every class (not include parent/base classes) must declare a constant with the key used on Redis. That means that each class can only have one instance (one key) saved on Redis. This make easier to control (retrieve, delete, etc) the data out of the class instance scope.
