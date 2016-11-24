//
//  InfoViewController.swift
//  Meet
//
//  Created by Benjamin Encz on 12/2/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class InfoViewController: UIViewController, Routable {

    static let identifier = "InfoViewController"

    @IBAction func cancelButtonTapped(_ sender: Any) {

        mainStore.dispatch(
            SetRouteAction(["TabBarViewController", StatsViewController.identifier])
        )
    }

}
