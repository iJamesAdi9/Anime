//
//  RegisterViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol RegisterDisplayLogic: AnyObject {
    func displayCheckPasswordsMatchSuccess(viewModel: Register.CheckPasswordsMatch.ViewModel)
    func displayCheckPasswordsMatchFailure(viewModel: Register.CheckPasswordsMatch.ViewModel)
    
    func displayRegisterSuccess(viewModel: Register.Register.ViewModel)
    func displayRegisterFailure(viewModel: Register.Register.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
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
    }
    
    // MARK: - IBAction
    
    @IBAction func registerPressed(_ sender: UIButton) {
        checkPasswordsMatch()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func checkPasswordsMatch() {
        let password: String = passwordTextField.text ?? ""
        let confirmPassword: String = confirmPasswordTextField.text ?? ""
        let request = Register.CheckPasswordsMatch.Request(password: password, confirmPassword: confirmPassword)
        interactor?.checkPasswordsMatch(request: request)
    }
    
    private func register() {
        ProgressHUDManager.shared.showProgress(view: view)
        
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        let request = Register.Register.Request(email: email, password: password)
        interactor?.register(request: request)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    // MARK: - Display
    
    func displayCheckPasswordsMatchSuccess(viewModel: Register.CheckPasswordsMatch.ViewModel) {
        register()
    }
    
    func displayCheckPasswordsMatchFailure(viewModel: Register.CheckPasswordsMatch.ViewModel) {
        showAlert(message: viewModel.message)
    }
    
    func displayRegisterSuccess(viewModel: Register.Register.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        SignOutManager.shared.signOut {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func displayRegisterFailure(viewModel: Register.Register.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        showAlert(message: viewModel.error?.localizedDescription ?? "")
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
