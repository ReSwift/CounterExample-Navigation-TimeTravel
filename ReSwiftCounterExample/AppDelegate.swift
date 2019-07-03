//
//  AppDelegate.swift
//  ReSwiftCounterExample
//
//  Created by Benjamin Encz on 12/1/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

var mainStore = Store<AppState>(reducer: AppReducer, state: AppState())

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var router: Router<AppState>!
    var window: UIWindow?

    var rootViewController: Routable!
    var counterViewController: UIViewController!
    var statsViewController: UIViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let tabBarController = UITabBarController()
        counterViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CounterViewController")
        statsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "StatsViewController")

        tabBarController.viewControllers = [counterViewController, statsViewController]
        tabBarController.delegate = self
        rootViewController = tabBarController

        router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController)) { state in
            state.select { $0.navigationState }
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

class RootRoutable: Routable {

    var routable: Routable

    init(routable: Routable) {
        self.routable = routable
    }

    public func pushRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler
    ) -> Routable {
        completionHandler()
        return self.routable
    }

    public func popRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) {
            completionHandler()
    }

}

extension AppDelegate: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController) -> Bool {

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

    public func changeRouteSegment(_ fromSegment: RouteElementIdentifier,
        to: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable {
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
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable {
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

    public func popRouteSegment(_ viewControllerIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) {
            // would need to unset root view controller here
            completionHandler()
    }

}
