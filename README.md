# Design Patterns
Design pattern practice in a few languages.

## What is this balderdash?
In essence, design patterns in software are like design patterns in any other
field. They are common patterns that have proven useful by experience and 
nothing more.

[Peter Norvig](http://norvig.com/) defines them as follows:
- Descriptions of what experienced designers know 
- Hints/reminders for choosing classes and methods
- Higher-order abstractions for program organization
- To discuss, weigh and record design tradeoffs
- To avoid limitations of implementation language

## Build Details
How to run these things!

### Java
Projects are scaffolded using Gradle. To build or test run:
```Bash
# When inside a project directory
gradle build
gradle test

# Run from elsewhere
gradle test -p strategy/java/
```

### Ruby
Script tests can be run as follows:
```Bash
ruby path/to/script_test.rb
```

### Objective-C
All projects are built with Xcode and can be built or tested using the awesome
[xctool](https://github.com/facebook/xctool) as follows:
```Bash
xctool -workspace YourWorkspace.xcworkspace \
 -scheme YourScheme \
 test # or build
```

### Swift
Projects follow the swift package manager conventions. To run tests:
```Bash
cd path/to/package
swift tests
```

### Javascript
Projects follow node/npm package conventions. To run tests:
```Bash
cd path/to/package
npm test
```

### (More to come later... hopefully)
