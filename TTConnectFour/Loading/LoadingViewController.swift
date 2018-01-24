//
//  LoadingViewController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, StateControllerHandler {

    //MARK: Properties
    
    var stateController: StateController?
    
    private let showTabSegueIdentifier = "PresentTabController"
    
    //MARK: Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateController?.load(completion: { completed in
            if completed {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: self.showTabSegueIdentifier, sender: self)
            }
        })
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var dvc = segue.destination as? StateControllerHandler else { return }
        dvc.stateController = stateController
    }

}
