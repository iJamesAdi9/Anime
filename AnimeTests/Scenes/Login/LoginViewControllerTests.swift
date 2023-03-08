//
//  LoginViewControllerTests.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 8/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Anime

class LoginViewControllerTests: XCTestCase {

    var viewController: LoginViewController!
    var mockInteractor: MockLoginInteractor!
    var mockRouter: MockLoginRouter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController

        mockInteractor = MockLoginInteractor()
        mockRouter = MockLoginRouter()

        viewController.interactor = mockInteractor
        viewController.router = mockRouter

        _ = viewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDoSomething() {
        viewController.login(email: "james@gmail.com", password: "123456")
        XCTAssertEqual(mockInteractor.loginRequest?.email, "james@gmail.com", "email")
    }
    
    func testRouteToMainViewController() {
        let viewModel = Login.Login.ViewModel(result: nil, error: nil)
        viewController.displayLoginSuccess(viewModel: viewModel)
        XCTAssertTrue(mockRouter.routeSuccess)
    }
}

class MockLoginInteractor: LoginBusinessLogic { 
    var doSomethingCalled = false
    var request: AnyObject?
    var loginRequest: Login.Login.Request?
    
    func login(request: Login.Login.Request) {
        loginRequest = request
    }
    
    func autoLogin(request: Login.AutuLogin.Request) {
        
    }
}

class MockLoginRouter: (LoginRoutingLogic & LoginDataPassing & NSObject) {
    var dataStore: Anime.LoginDataStore?
    var routeSuccess: Bool = false
    
    func routeToMainViewController(segue: UIStoryboardSegue?) {
        routeSuccess = true
    }
}
