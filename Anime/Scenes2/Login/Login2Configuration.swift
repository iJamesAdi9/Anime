//
//  Login2Configuration.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class Login2Configuration {
    static let shared: Login2Configuration = Login2Configuration()
    
    func configure(_ viewController: Login2ViewController) {
        let interactor = Login2Interactor()
        let presenter = Login2Presenter()
        let router = Login2Router()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
