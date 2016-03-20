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

    func pushRouteSegment(viewControllerIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) -> Routable {

            infoViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewControllerWithIdentifier("InfoViewController") as! Routable

            presentViewController(infoViewController as! UIViewController, animated: false,
                completion: completionHandler)

            return infoViewController
    }

    func popRouteSegment(identifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) {

        dismissViewControllerAnimated(false, completion: completionHandler)
    }

    @IBAction func pushButtonTapped(sender: UIButton) {
        mainStore.dispatch(
            SetRouteAction(["TabBarViewController", StatsViewController.identifier,
                    InfoViewController.identifier])
        )
    }

}