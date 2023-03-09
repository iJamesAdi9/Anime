//
//  Login2Interactor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Login2Interactor {
    var presenter: Login2PresentationLogic?
    var worker: Login2WorkerProtocol?
    
    required init(presenter: Login2PresentationLogic? = nil,
                  worker: Login2WorkerProtocol? = Login2Worker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension Login2Interactor: Login2DataStore, Login2BusinessLogic {
    func login(request: Login2.Login.Request) {
        worker?.login(request, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage: String = error.localizedDescription
                self.presenter?.presentErrorMessage(errorMessage: errorMessage)
            } else {
                let response = Login2.Login.Response()
                self.presenter?.presentLoginSuccess(response: response)
            }
        })
    }
    
    func autoLogin(request: Login2.AutoLogin.Request) {
        worker?.autoLogin(request, completionHandler: { [weak self] (isSignedIn) in
            guard let self = self else { return }
            
            let response = Login2.AutoLogin.Response(isSignedIn: isSignedIn ?? false)
            self.presenter?.presentAutoLoginSuccess(response: response)
        })
    }
}
