//
//  NavigationAction.swift
//  Meet
//
//  Created by Benjamin Encz on 11/27/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import SwiftFlow

/// Exports the type map needed for using Swift Flow Router with a Recording Store
public let typeMap: [String: StandardActionConvertible.Type] =
    ["SWIFT_FLOW_ROUTER_SET_ROUTE": SetRouteAction.self]

public struct SetRouteAction: StandardActionConvertible {

    let route: [RouteElementIdentifier]
    public static let type = "SWIFT_FLOW_ROUTER_SET_ROUTE"

    public init (_ route: [RouteElementIdentifier]) {
        self.route = route
    }

    public init(_ action: StandardAction) {
        self.route = action.payload!["route"] as! [RouteElementIdentifier]
    }

    public func toStandardAction() -> StandardAction {
        return StandardAction(type: SetRouteAction.type, payload: ["route": route], isTypedAction: true)
    }
    
}