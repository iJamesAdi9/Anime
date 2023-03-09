//
//  Register2Protocol.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ViewController

protocol Register2DisplayLogic {
    func displayRegisterSuccess(viewModel: Register2.Register.ViewModel)
    func displayCheckPasswordsMatchSuccess(viewModel: Register2.CheckPasswordsMatch.ViewModel)
    func displayErrorMessage(errorMessage: String)
}

// MARK: - Interactor
protocol Register2BusinessLogic {
    func checkPasswordsMatch(request: Register2.CheckPasswordsMatch.Request)
    func register(request: Register2.Register.Request)
}

// MARK: - Presenter

protocol Register2PresentationLogic {
    func presentCheckPasswordsMatch(response: Register2.CheckPasswordsMatch.Response)
    func presentRegister(response: Register2.Register.Response)
    func presentErrorMessage(errorMessage: String)
}

// MARK: - Worker

protocol Register2WorkerProtocol {
    func register(_ request: Register2.Register.Request, completionHandler: @escaping (_ error: Error?) -> ())
}

// MARK: - Routable

@objc protocol Register2RoutingLogic {
}

// MARK: - DataStore
protocol Register2DataStore {
}

// MARK: - DataPassing

protocol Register2DataPassing {
    var dataStore: Register2DataStore? { get }
}
