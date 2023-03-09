//
//  Register2Interactor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Register2Interactor {
    var presenter: Register2PresentationLogic?
    var worker: Register2WorkerProtocol?
    
    required init(presenter: Register2PresentationLogic? = nil,
                  worker: Register2WorkerProtocol? = Register2Worker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension Register2Interactor: Register2DataStore, Register2BusinessLogic {
    func checkPasswordsMatch(request: Register2.CheckPasswordsMatch.Request) {
        let password: String = request.password
        let confirmPassword: String = request.confirmPassword
        
        if password.isEqual(confirmPassword) {
            let response = Register2.CheckPasswordsMatch.Response(isMatch: true)
            presenter?.presentCheckPasswordsMatch(response: response)
        } else {
            let response = Register2.CheckPasswordsMatch.Response(isMatch: false)
            presenter?.presentCheckPasswordsMatch(response: response)
        }
    }
    
    func register(request: Register2.Register.Request) {
        worker?.register(request, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            let response = Register2.Register.Response(error: error)
            self.presenter?.presentRegister(response: response)
        })
    }
}
