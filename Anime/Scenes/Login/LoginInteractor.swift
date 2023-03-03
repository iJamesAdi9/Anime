//
//  LoginInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic {
    func login(request: Login.Login.Request)
}

protocol LoginDataStore {
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker? = LoginWorker()
    
    // MARK: Do something
    
    func login(request: Login.Login.Request) {
        worker?.login(request, completionHandler: { [weak self] (result, error) in
            guard let self = self else { return }
            let response = Login.Login.Response(result: result, error: error)
            self.presenter?.presentLogin(response: response)
        })
    }
}
