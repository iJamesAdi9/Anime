//
//  Login2Presenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Login2Presenter {
    var viewController: Login2DisplayLogic?
    
    required init(viewController: Login2DisplayLogic? = nil) {
        self.viewController = viewController
    }
}

extension Login2Presenter: Login2PresentationLogic {
    func presentLoginSuccess(response: Login2.Login.Response) {
        let viewModel = Login2.Login.ViewModel(email: nil, password: nil)
        viewController?.displayLoginSuccess(viewModel: viewModel)
    }
    
    func presentAutoLoginSuccess(response: Login2.AutoLogin.Response) {
        if response.isSignedIn {
            let viewModel = Login2.AutoLogin.ViewModel(isSignedIn: response.isSignedIn)
            viewController?.displayAutoLoginSuccess(viewModel: viewModel)
        }
    }
    
    func presentErrorMessage(errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage: errorMessage)
    }
}
