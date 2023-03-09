//
//  Login2Protocol.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ViewController

protocol Login2DisplayLogic: AnyObject {
    func displayLoginSuccess(viewModel: Login2.Login.ViewModel)
    func displayAutoLoginSuccess(viewModel: Login2.AutoLogin.ViewModel)
    func displayErrorMessage(errorMessage: String)
}

// MARK: - Interactor
protocol Login2BusinessLogic {
    func login(request: Login2.Login.Request)
    func autoLogin(request: Login2.AutoLogin.Request)
}

// MARK: - Presenter

protocol Login2PresentationLogic {
    func presentLoginSuccess(response: Login2.Login.Response)
    func presentAutoLoginSuccess(response: Login2.AutoLogin.Response)
    func presentErrorMessage(errorMessage: String)
}

// MARK: - Worker

protocol Login2WorkerProtocol {
    func login(_ request: Login2.Login.Request, completionHandler: @escaping (_ error: Error?) -> ())
    func autoLogin(_ request: Login2.AutoLogin.Request, completionHandler: @escaping (_ isSignedIn: Bool?) -> ())
}

// MARK: - Routable

@objc protocol Login2RoutingLogic {
    func routeToMainViewController()
    func showErrorMessage(errorMessage: String)
}

// MARK: - DataStore
protocol Login2DataStore {
}

// MARK: - DataPassing

protocol Login2DataPassing {
    var dataStore: Login2DataStore? { get }
}
