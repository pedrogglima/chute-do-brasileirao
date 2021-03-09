# Caches

- Classes found here are used to encapsulate logic for Redis DB calls.
- Because Redis DB save values in string format, these classes need to change from Active Record type to a format that can be easily change to string, we use a Hash here.
- On the folder caches/base you will find the parents/base classes.
- Every class (not include parent/base classes) must declare a constant with the key used on Redis. That means that each class can only have one instance (one key) saved on Redis. This make easier to control (retrieve, delete, etc) the data.
