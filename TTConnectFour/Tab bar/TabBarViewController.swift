//
//  TabBarViewController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate, StateControllerHandler {

    var stateController: StateController?

    //MARK: Viewcontroller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignStateController()
        self.delegate = self
    }
    
    private func assignStateController() {
        var dvc: StateControllerHandler?
        if let destination = viewControllers?.first as? UINavigationController {
            guard let firstController = destination.viewControllers.first as? StateControllerHandler else { return }
            dvc = firstController
        } else if let destination = viewControllers?.first as? StateControllerHandler {
            dvc = destination
        }
        dvc?.stateController = stateController
    }
    
    //MARK: Tab bar controller delegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var dvc: StateControllerHandler?
        if let destination = viewController as? UINavigationController {
            guard let firstController = destination.viewControllers.first as? StateControllerHandler else { return true }
            dvc = firstController
        } else if let destination = viewController as? StateControllerHandler {
            dvc = destination
        }
        dvc?.stateController = stateController
        return true
    }

}
