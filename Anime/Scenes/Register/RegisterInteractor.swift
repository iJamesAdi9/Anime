//
//  RegisterInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RegisterBusinessLogic {
    func checkPasswordsMatch(request: Register.CheckPasswordsMatch.Request)
    func register(request: Register.Register.Request)
}

protocol RegisterDataStore {
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorker? = RegisterWorker()
    
    // MARK: Do something
    
    func checkPasswordsMatch(request: Register.CheckPasswordsMatch.Request) {
        let password: String = request.password
        let confirmPassword: String = request.confirmPassword
        
        if password.isEqual(confirmPassword) {
            let response = Register.CheckPasswordsMatch.Response(isMatch: true)
            presenter?.presentCheckPasswordsMatch(response: response)
        } else {
            let response = Register.CheckPasswordsMatch.Response(isMatch: false)
            presenter?.presentCheckPasswordsMatch(response: response)
        }
    }
    
    func register(request: Register.Register.Request) {
        worker?.register(request, completionHandler: { [weak self] (authDataResult, error) in
            guard let self = self else { return }
            let response = Register.Register.Response(result: authDataResult, error: error)
            self.presenter?.presentRegister(response: response)
        })
    }
}
