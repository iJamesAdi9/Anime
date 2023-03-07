//
//  RegisterPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RegisterPresentationLogic {
    func presentCheckPasswordsMatch(response: Register.CheckPasswordsMatch.Response)
    func presentRegister(response: Register.Register.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    // MARK: Do something
    
    func presentCheckPasswordsMatch(response: Register.CheckPasswordsMatch.Response) {
        if response.isMatch {
            let viewModel = Register.CheckPasswordsMatch.ViewModel(message: "Password is match.")
            viewController?.displayCheckPasswordsMatchSuccess(viewModel: viewModel)
        } else {
            let viewModel = Register.CheckPasswordsMatch.ViewModel(message: "Password is not match.")
            viewController?.displayCheckPasswordsMatchFailure(viewModel: viewModel)
        }
    }
    
    func presentRegister(response: Register.Register.Response) {
        if let result = response.result {
            let viewModel = Register.Register.ViewModel(result: result, error: nil)
            viewController?.displayRegisterSuccess(viewModel: viewModel)
        } else {
            let viewModel = Register.Register.ViewModel(result: nil, error: response.error)
            viewController?.displayRegisterFailure(viewModel: viewModel)
        }
    }
}
