//
//  FavoriteListRouter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol FavoriteListRoutingLogic {
    func routeToDetailViewController(segue: UIStoryboardSegue?)
}

protocol FavoriteListDataPassing {
    var dataStore: FavoriteListDataStore? { get }
}

class FavoriteListRouter: NSObject, FavoriteListRoutingLogic, FavoriteListDataPassing {
    weak var viewController: FavoriteListViewController?
    var dataStore: FavoriteListDataStore?
    
    // MARK: Routing
    
    func routeToDetailViewController(segue: UIStoryboardSegue?) {
        guard let segue = segue else { return }
        let destinationVC = segue.destination as! DetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailViewController(source: dataStore!, destination: &destinationDS)
    }
    
    // MARK: Passing data
    
    func passDataToDetailViewController(source: FavoriteListDataStore, destination: inout DetailDataStore) {
        destination.mangaData = source.favoriteData
    }
}
