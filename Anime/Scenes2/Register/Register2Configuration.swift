//
//  Register2Configuration.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class Register2Configuration {
    static let shared: Register2Configuration = Register2Configuration()
    
    func configure(_ viewController: Register2ViewController) {
        let interactor = Register2Interactor()
        let presenter = Register2Presenter()
        let router = Register2Router()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
