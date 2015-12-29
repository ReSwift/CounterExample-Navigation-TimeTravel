//
//  Fakes.swift
//  SwiftFlow
//
//  Created by Benji Encz on 12/24/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation
@testable import SwiftFlow

struct TestAppState: StateType {
    var testValue: Int?

    init() {
        testValue = nil
    }
}

struct TestStringAppState: StateType {
    var testValue: String?

    init() {
        testValue = nil
    }
}

struct SetValueAction: StandardActionConvertible {

    let value: Int
    static let type = "SetValueAction"

    init (_ value: Int) {
        self.value = value
    }

    init(_ standardAction: StandardAction) {
        self.value = standardAction.payload!["value"] as! Int
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: SetValueAction.type, payload: ["value": value])
    }

}

struct SetValueStringAction: StandardActionConvertible {

    var value: String
    static let type = "SetValueStringAction"

    init (_ value: String) {
        self.value = value
    }

    init(_ standardAction: StandardAction) {
        self.value = standardAction.payload!["value"] as! String
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: SetValueStringAction.type, payload: ["value": value])
    }

}

struct TestReducer: Reducer {
    func handleAction(var state: TestAppState, action: Action) -> TestAppState {
        switch action {
        case let action as SetValueAction:
            state.testValue = action.value
            return state
        default:
            return state
        }
    }
}

struct TestValueStringReducer: Reducer {
    func handleAction(var state: TestStringAppState, action: Action) -> TestStringAppState {
        switch action {
        case let action as SetValueStringAction:
            state.testValue = action.value
            return state
        default:
            return state
        }
    }
}

class TestStoreSubscriber<T>: StoreSubscriber {
    var receivedStates: [T] = []

    func newState(state: T) {
        receivedStates.append(state)
    }
}
