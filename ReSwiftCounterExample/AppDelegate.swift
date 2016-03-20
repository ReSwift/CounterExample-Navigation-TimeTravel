//
//  AppDelegate.swift
//  ReSwiftCounterExample
//
//  Created by Benjamin Encz on 12/1/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRecorder
import ReSwiftRouter

var mainStore = RecordingMainStore<AppState>(
        reducer: AppReducer(),
        state: nil,
        typeMaps:[counterActionTypeMap, ReSwiftRouter.typeMap],
        recording: "recording.json"
    )

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var router: Router<AppState>!
    var window: UIWindow?

    var rootViewController: Routable!
    var counterViewController: UIViewController!
    var statsViewController: UIViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let tabBarController = UITabBarController()
        counterViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("CounterViewController")
        statsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("StatsViewController")

        tabBarController.viewControllers = [counterViewController, statsViewController]
        tabBarController.delegate = self
        rootViewController = tabBarController

        router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController)) { state in
            state.navigationState
        }

        mainStore.dispatch { state, store in
                if state.navigationState.route == [] {
                    return SetRouteAction(["TabBarViewController", StatsViewController.identifier,
                            InfoViewController.identifier])
                } else {
                    return nil
                }
        }



        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        mainStore.rewindControlYOffset = 150
        mainStore.window = window

        return true
    }

}

class RootRoutable: Routable {

    var routable: Routable

    init(routable: Routable) {
        self.routable = routable
    }

    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) -> Routable {
            completionHandler()
            return routable
    }

    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) {
            completionHandler()
    }

}

extension AppDelegate: UITabBarControllerDelegate {

    func tabBarController(tabBarController: UITabBarController,
        shouldSelectViewController viewController: UIViewController) -> Bool {

        if viewController is CounterViewController {
            mainStore.dispatch(
                SetRouteAction(["TabBarViewController", CounterViewController.identifier])
            )
        } else if viewController is StatsViewController {
            mainStore.dispatch(
                SetRouteAction(["TabBarViewController", StatsViewController.identifier])
            )
        }
        
        return false
    }

}

extension UITabBarController: Routable {

    public func changeRouteSegment(fromSegment: RouteElementIdentifier,
        to: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) -> Routable {
            if (to == CounterViewController.identifier) {
                selectedIndex = 0
                completionHandler()
                return viewControllers![0] as! Routable
            } else if (to == StatsViewController.identifier) {
                selectedIndex = 1
                completionHandler()
                return viewControllers![1] as! Routable
            }

            abort()
    }

    public func pushRouteSegment(
        routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) -> Routable {
            if (routeElementIdentifier == CounterViewController.identifier) {
                selectedIndex = 0
                completionHandler()
                return viewControllers![0] as! Routable
            } else if (routeElementIdentifier == StatsViewController.identifier) {
                selectedIndex = 1
                completionHandler()
                return viewControllers![1] as! Routable
            }

            abort()
    }

    public func popRouteSegment(viewControllerIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: RoutingCompletionHandler) {
            // would need to unset root view controller here
            completionHandler()
    }

}
