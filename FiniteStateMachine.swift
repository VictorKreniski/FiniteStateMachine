//
//  FiniteStateMachine.swift
//
//  Created by Victor Oliveira Kreniski on 16/11/17.
//  Copyright © 2017 Victor Oliveira Kreniski. All rights reserved.
//

import Foundation

/**
 
 This class is a generic representation of finite state machine
 - Important: State hashable parameter must be the Hashable with all the possible states (Examples: Idle, Jump )
 - Important: ActionTypes hashable parameter must be the hashable with all the Action with minemonic names (Example: IdleToJump)
 - Author: Victor Kreniski
 */
public final class FiniteStateMachine<State: Hashable, ActionTypes: Hashable> {
    
    //MARK: - Properties
    // The actual state in some moment will be saved here
    public private(set) var currentState: State
    // The array with all possible actions
    private var actions = [State:[ActionTypes:State]]()
    
    //MARK: - Init
    /**
     Class Init with the initial state
     - parameters:
        - initialState: State object representing the first state.
     */
    public init(initialState: State) {
        self.currentState = initialState
    }
    
    //MARK: - Methods
    /**
     addAction is a method able to add the possible action on the action hash array
     - parameters:
        - action: Action hash object.
        - first: First State object
        - second: Second State object
     */
    public final func addAction(_ action: ActionTypes, from first: State, to second: State) {
        //checks if the action dictionary in the first state is nil
        if actions[first] == nil {
            actions[first] = [:]
        }
        actions[first]?[action] = second
    }
    
    /**
     This method returns an answer if the action can advance
     - parameters:
        - action: Action hash object.
     */
    public final func canExecute(action: ActionTypes) -> Bool {
        return actions[self.currentState]?[action] != nil
    }
    
    // Type aliases allow developers to define synonyms for pre-existing types.
    // Simple typealias
    public typealias CompletionHandler = (_ old: State,_ new: State) -> ()
    /**
     This method will make you advance into the next action, if possible.
     - parameters:
        - action: Action hash object.
        - completition: CompletionHandler
        - returns: State Object
     */
    public final func execute(action: ActionTypes, completion: CompletionHandler? = nil){
        let previousState = self.currentState
        if let nextState = actions[previousState]?[action], nextState != previousState {
            self.currentState = nextState
            completion?(previousState, nextState)
        }
    }
    
}

