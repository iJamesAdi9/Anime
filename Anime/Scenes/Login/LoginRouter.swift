//
//  LoginRouter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToMainViewController(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    func routeToMainViewController(segue: UIStoryboardSegue?) {
        guard let segue = segue else { return }
        let destinationVC = segue.destination as! MainViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMainViewController(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    
    private func passDataToMainViewController(source: LoginDataStore, destination: inout MainDataStore) {   
    }
}
