//
//  Register2Presenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Register2Presenter {
    var viewController: Register2DisplayLogic?
    
    required init(viewController: Register2DisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension Register2Presenter: Register2PresentationLogic {
    func presentCheckPasswordsMatch(response: Register2.CheckPasswordsMatch.Response) {
        if !response.isMatch {
            presentErrorMessage(errorMessage: "Password is not match.")
        } else {
            let viewModel = Register2.CheckPasswordsMatch.ViewModel(message: "")
            viewController?.displayCheckPasswordsMatchSuccess(viewModel: viewModel)
        }
    }
    
    func presentRegister(response: Register2.Register.Response) {
        if let error = response.error {
            let erroeMessage: String = error.localizedDescription
            presentErrorMessage(errorMessage: erroeMessage)
        } else {
            let viewModel = Register2.Register.ViewModel(error: nil)
            viewController?.displayRegisterSuccess(viewModel: viewModel)
        }
    }
    
    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
