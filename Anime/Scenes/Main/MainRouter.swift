//
//  MainRouter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol MainRoutingLogic {
    func routeToDetailViewController(segue: UIStoryboardSegue?)
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: Routing
    
    func routeToDetailViewController(segue: UIStoryboardSegue?) {
        guard let segue = segue else { return }
        let destinationVC = segue.destination as! DetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailViewController(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    
    func passDataToDetailViewController(source: MainDataStore, destination: inout DetailDataStore) {
        destination.mangaData = source.mangaData
    }
}
