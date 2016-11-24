//
//  StatsViewController.swift
//  Meet
//
//  Created by Benjamin Encz on 12/1/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class StatsViewController: UIViewController, Routable {

    static let identifier = "StatsViewController"

    var infoViewController: Routable!

    func pushRouteSegment(_ viewControllerIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable {

            infoViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "InfoViewController") as! Routable

            present(infoViewController as! UIViewController, animated: false,
                completion: completionHandler)

            return infoViewController
    }

    func popRouteSegment(_ identifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) {

        dismiss(animated: false, completion: completionHandler)
    }

    @IBAction func pushButtonTapped(_ sender: Any) {
        _ = mainStore.dispatch(
            SetRouteAction(["TabBarViewController", StatsViewController.identifier,
                            InfoViewController.identifier])
        )
    }

}
