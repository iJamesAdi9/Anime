//
//  Login2Router.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Login2Router: NSObject, Login2RoutingLogic, Login2DataPassing {
    // MARK: Properties
    
    weak var viewController: Login2ViewController?
    var dataStore: Login2DataStore?
    
    // MARK: - Routing
    
    func routeToMainViewController() {
        if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMainViewController(source: dataStore!, destination: &destinationDS)
            navigateToMainViewController(source: viewController, destination: destinationVC)
        }
    }
    
    func showErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        viewController?.present(alert, animated: true)
    }
    
    // MARK: - Navigation
    
    func navigateToMainViewController(source: Login2ViewController?, destination: MainViewController) {
        source?.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    
    func passDataToMainViewController(source: Login2DataStore, destination: inout MainDataStore) {
    }
}
