//
//  LoginViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol LoginDisplayLogic: AnyObject {
    func displayLoginSuccess(viewModel: Login.Login.ViewModel)
    func displayLoginFailure(viewModel: Login.Login.ViewModel)
    
    func displayAutoLoginSuccess(viewModel: Login.AutuLogin.ViewModel)
    func displayAutoLoginFailure(viewModel: Login.AutuLogin.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    
    // MARK: - Properties
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin()
    }
    
    // MARK: - IBAction
    
    @IBAction func loginPressed(_ sender: UIButton) {
        login()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func autoLogin() {
        let request = Login.AutuLogin.Request()
        interactor?.autoLogin(request: request)
    }
    
    private func login() {
        ProgressHUDManager.shared.showProgress(view: view)
        
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        let request = Login.Login.Request(email: email, password: password)
        interactor?.login(request: request)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // MARK: - Display
    
    func displayLoginSuccess(viewModel: Login.Login.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        performSegue(withIdentifier: "RouteToMainViewController", sender: nil)
    }
    
    func displayAutoLoginSuccess(viewModel: Login.AutuLogin.ViewModel) {
        performSegue(withIdentifier: "RouteToMainViewController", sender: nil)
    }
    
    func displayLoginFailure(viewModel: Login.Login.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        showAlert(message: viewModel.error?.localizedDescription ?? "")
    }
    
    func displayAutoLoginFailure(viewModel: Login.AutuLogin.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}
