# Model View Controller Pattern
Traditionally used to develop user interfaces. The pattern divides an 
application into three kinds of components. A `model`, captures the behavior 
of the application in terms of its problem domain, independent of the user 
interface. The `model` directly manages the data, logic and rules of the application.
A `view` is any output representation of information or data. Multiple `views`
of the same information is possible. A `controller` accepts input and can 
send commands to `models` and `views`.
