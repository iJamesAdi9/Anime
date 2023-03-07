//
//  DetailRouter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol DetailRoutingLogic {
    func routeToWebViewController(segue: UIStoryboardSegue?)
}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailRoutingLogic, DetailDataPassing {
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
    
    // MARK: Routing
    
    func routeToWebViewController(segue: UIStoryboardSegue?) {
        guard let segue = segue else { return }
        let destinationVC = segue.destination as! WebViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToWebViewController(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    
    func passDataToWebViewController(source: DetailDataStore, destination: inout WebDataStore) {
        destination.mangaData = source.mangaData
    }
}
