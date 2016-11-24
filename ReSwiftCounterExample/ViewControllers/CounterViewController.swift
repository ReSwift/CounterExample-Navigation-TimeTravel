//
//  ViewController.swift
//  ReSwiftCounterExample
//
//  Created by Benjamin Encz on 12/1/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class CounterViewController: UIViewController, StoreSubscriber, Routable {

    static let identifier = "CounterViewController"

    @IBOutlet var counterLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }

    func newState(state: AppState) {
        counterLabel.text = "\(state.counter)"
    }

    @IBAction func increaseButtonTapped(_ sender: Any) {
        mainStore.dispatch(
            CounterActionIncrease()
        )
    }

    @IBAction func decreaseButtonTapped(_ sender: Any) {
        mainStore.dispatch(
            CounterActionDecrease()
        )
    }

}
