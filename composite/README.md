# Composite Pattern
The composite pattern describes that individual objects and compositions
of objects can be treated uniformly. The intent of the pattern is to 
'compose' objects into tree structures such that leaf-nodes and 
branch-nodes can be operated on without distinction.

The common interface of the objects is defined as the ``component``. The
``composite`` is a ``component`` but is also built of subcomponents or
``leaf`` classes. Leaf classes also conform to the ``component`` interface.

## Related design principles
- Don't repeat yourself
- Program to an interface, not an implementation
