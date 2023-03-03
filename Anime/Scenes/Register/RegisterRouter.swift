//
//  RegisterRouter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol RegisterRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RegisterDataPassing {
    var dataStore: RegisterDataStore? { get }
}

class RegisterRouter: NSObject, RegisterRoutingLogic, RegisterDataPassing {
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: RegisterViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: RegisterDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
