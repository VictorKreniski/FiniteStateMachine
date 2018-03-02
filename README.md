# Usefull Finite State Machine in Swift Language i've developed to help my iOS Game - [Chicken Sneakers](https://itunes.apple.com/br/app/chicken-sneakers/id1322624270?mt=8)

## For more information, check out the [wiki](https://github.com/krevi27/FiniteStateMachine/wiki)

## Declaring the Finite State Machine into your project

1. First you must create a **hashable object** with the possible states

```swift
enum PlayerStates{
    case Idle, Jump, Duck, Dead
}
```
2. Second you must create a **hashable object** with all the possible actions in between states
```swift
enum PlayerActions{
    case IdleToJump, JumpToIdle, IdleToDuck, DuckToIdle, AliveToDead, DeadToIdle
}
```
3. Third you must **declare** your **finite state machine** as a **property** in the object, giving to the Finite State Machine both of the hashable objects in this order: States Hashable Object for the paramater ( State: Hashable ) and an Action Hashable Object for the parameter ( ActionTypes: Hashable )
```swift
class Player {
    var finiteStateMachine: FiniteStateMachine<PlayerStates, PlayerActions>?
}
```
### Then you are good to **init** the Finite State Machine and **set** your initial State 
```swift
self.finiteStateMachine = FiniteStateMachine(initialState: .Idle)
```
### After setting the first state you must set all the possible actions 
1. First parameter is the action you want to create a reference between two states
2. Second parameter is the state you must be in order to go the next 
3. Third parameter is the state you will go if the action is valid.
```swift
self.finiteStateMachine?.addAction(.IdleToJump, from: .Idle, to: .Jump)
self.finiteStateMachine?.addAction(.JumpToIdle, from: .Jump, to: .Idle)
self.finiteStateMachine?.addAction(.IdleToDuck, from: .Idle, to: .Duck)
self.finiteStateMachine?.addAction(.DuckToIdle, from: .Duck, to: .Idle)
```
## How to operate the Finite State Machine
### You have three ways of operating the state machine
1. Asking the finite state machine if a action is valid giving the actual state
2. Asking the finite state machine to execute an action. The action will only be executed if a action is valid
3. Asking the finite state machine to execute an action with a completion. The action and the completion will only be executed if a action is valid

### Example
* This code will ask the finite state machine if action **.IdleToJump** is valid. The giving state in the object in this instant is .Idle, so the method will return **True**.
```swift
player.finiteStateMachine?.canAdvanceTo(action: .IdleToJump)
```
* This code will ask the finite state machine again if action **.JumpToIdle **is valid. Different from the other Action, this one is not valid, the finite state machine does not support a action **.JumpToIdle** if the actual state still **.Idle**
```swift
player.finiteStateMachine?.canAdvanceTo(action: .JumpToIdle)
```
* To make the action **.JumpToIdle** a valid one, first we must ask the finite state machine to execute a action **.IdleToJump**
```swift
player.finiteStateMachine?.advanceTo(action: .IdleToJump)
```
* Now that we are in State **.Jump** we can ask the finite state machine again to execute another action **.JumpToIdle**. Now, we're using completion to print after the action is done and the states are changed
```swift
player.finiteStateMachine?.advanceTo(action: .JumpToIdle, completion: { (old, new) in
    print("Coming from Idle and going to Duck")
})
```
