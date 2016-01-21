//
//  CounterActions.swift
//  Meet
//
//  Created by Benjamin Encz on 12/1/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRecorder

let counterActionTypeMap: TypeMap = [CounterActionIncrease.type: CounterActionIncrease.self,
                                  CounterActionDecrease.type: CounterActionDecrease.self]

struct CounterActionIncrease: StandardActionConvertible {

    static let type = "COUNTER_ACTION_INCREASE"

    init() {}
    init(_ standardAction: StandardAction) {}

    func toStandardAction() -> StandardAction {
        return StandardAction(type: CounterActionIncrease.type, payload: [:], isTypedAction: true)
    }

}

struct CounterActionDecrease: StandardActionConvertible {

    static let type = "COUNTER_ACTION_DECREASE"

    init() {}
    init(_ standardAction: StandardAction) {}

    func toStandardAction() -> StandardAction {
        return StandardAction(type: CounterActionDecrease.type, payload: [:], isTypedAction: true)
    }

}