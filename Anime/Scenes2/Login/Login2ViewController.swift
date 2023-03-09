//
//  Login2ViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Login2ViewController: UIViewController {
    
    // MARK: Properties
    
    var interactor: Login2BusinessLogic?
    var router: (Login2RoutingLogic & Login2DataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    // MARK: - View lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin()
    }
    
    // MARK: - IBAction
    
    @IBAction func loginPressed(_ sender: UIButton) {
        login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    // MARK: - Call interactor
    
    func autoLogin() {
        let request: Login2.AutoLogin.Request = Login2.AutoLogin.Request()
        interactor?.autoLogin(request: request)
    }
    
    func login(email: String, password: String) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Login2.Login.Request(email: email, password: password)
        interactor?.login(request: request)
    }
}

// MARK: - Display

extension Login2ViewController : Login2DisplayLogic {
    func displayLoginSuccess(viewModel: Login2.Login.ViewModel) {
        emailTextField.text = viewModel.email
        passwordTextField.text = viewModel.password
        view.endEditing(true)
        ProgressHUDManager.shared.dismissProgress()
        router?.routeToMainViewController()
    }
    
    func displayAutoLoginSuccess(viewModel: Login2.AutoLogin.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        router?.routeToMainViewController()
    }
    
    func displayErrorMessage(errorMessage: String) {
        ProgressHUDManager.shared.dismissProgress()
        router?.showErrorMessage(errorMessage: errorMessage)
    }
}

// MARK: Setup & Configuration

extension Login2ViewController {
    private func configure() {
        Login2Configuration.shared.configure(self)
    }
}
