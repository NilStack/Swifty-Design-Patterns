//: Playground - noun: a place where people can play

import UIKit
import Foundation

/*:
 Mediator
 -----------
 
 */
/*:
 ### Example
 */

class Mediator {
    var colleagues: [Colleague] = []
    func operation(receiver: Colleague, message: String) {
    
    }
}

protocol Colleague {
    var mediator: Mediator {get set}
    
    func send(receiver: Colleague, message: String)
    func receive(message: String)
}

class Developer: Colleague {
    
    internal var mediator: Mediator
    
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func send(receiver: Colleague, message: String) {
        
    }
    
    func receive(message: String) {
        
    }
}

/*:
 Observer
 -----------
 
 */
/*:
 ### Example
 */

class Subject {
    var state = 0
    var observers: [Observer] = []
    
    func attach(observer: Observer) {
        observers.append(observer)
    }
    
    func deattach(observer: Observer) {
        if let index = observers.index(where: {$0.identifier == observer.identifier}) {
            observers.remove(at: index)
        }
    }
    
    func notify() {
        observers.forEach { observer in
            observer.update(subject: self)
        }
    }
    
}

protocol Observer {
    var identifier: String {get}
    func update(subject: Subject)
}

class ConcreteObserver: Observer {
    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    func update(subject: Subject) {
        print("subject state \(subject.state),update observer \(identifier).")
    }
}


/*:
 ### Usage
 */

let subject = Subject()

let observerA = ConcreteObserver(identifier: "A")
let observerB = ConcreteObserver(identifier: "B")

subject.attach(observer: observerA)
subject.attach(observer: observerB)

subject.state = 1
subject.notify()

subject.deattach(observer: observerB)
subject.state = 2
subject.notify()


/*:
 State
 -----------
 
 ![State Pattern](State.png)
 
 */
/*:
 ### Example
 */

protocol State {
    func handle(context: Context)
}

class StateA: State {
    func handle(context: Context) {
        print("doing something in State A.\n done,change state to B")
        context.change(state: StateB())
    }
}

class StateB: State {
    func handle(context: Context) {
        print("doing something in State B.\n done,change state to A")
        context.change(state: StateA())
    }
}

class Context {
    var state: State = StateA()
    
    func change(state: State) {
        self.state = state
    }
    
    func request() {
        state.handle(context: self)
    }
}

/*:
 ### Usage
 */

let context = Context()
context.state
context.request()
context.state
context.request()
context.state

/*:
 Strategy
 -----------
 
 ![Strategy Pattern](Strategy.png)
 
 */
/*:
 ### Example
 */
protocol BrakeStrategy {
    func brake()
}

final class Brake {
    
    private let strategy: BrakeStrategy
    
    func brake() {
        self.strategy.brake()
    }
    
    init(strategy: BrakeStrategy) {
        self.strategy = strategy
    }
}

final class BrakeWithABS: BrakeStrategy {
    func brake() {
        print("Brake with ABS")
    }
}

final class SimpleBrake: BrakeStrategy {
    func brake() {
        print("Simple brake")
    }
}
/*:
 ### Usage
 */
var brake1 = Brake(strategy: BrakeWithABS())
brake1.brake()

var brake2 = Brake(strategy: SimpleBrake())
brake2.brake()
