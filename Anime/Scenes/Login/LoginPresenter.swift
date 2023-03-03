//
//  LoginPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentLogin(response: Login.Login.Response)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentLogin(response: Login.Login.Response) {
        if let result = response.result {
            let viewModel = Login.Login.ViewModel(result: result, error: nil)
            viewController?.displayLoginSuccess(viewModel: viewModel)
        } else {
            let viewModel = Login.Login.ViewModel(result: nil, error: response.error)
            viewController?.displayLoginFailure(viewModel: viewModel)
        }
    }
}
