//
//  Register2ViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Register2ViewController: UIViewController {
    
    // MARK: Properties
    
    var interactor: Register2BusinessLogic?
    var router: (Register2RoutingLogic & Register2DataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
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
    }
    
    // MARK: - IBAction
    
    @IBAction private func registerPressed(_ sender: UIButton) {
        let password: String = passwordTextField.text ?? ""
        let confirmPassword: String = confirmPasswordTextField.text ?? ""
        checkPasswordsMatch(password: password, confirmPassword: confirmPassword)
    }
    
    // MARK: - General function
    
    // MARK: - Call interactor

    func checkPasswordsMatch(password: String, confirmPassword: String) {
        let request = Register2.CheckPasswordsMatch.Request(password: password, confirmPassword: confirmPassword)
        interactor?.checkPasswordsMatch(request: request)
    }
    
    func register(email: String, password: String) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Register2.Register.Request(email: email, password: password)
        interactor?.register(request: request)
    }
}

// MARK: - Display

extension Register2ViewController: Register2DisplayLogic {
    func displayCheckPasswordsMatchSuccess(viewModel: Register2.CheckPasswordsMatch.ViewModel) {
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        register(email: email, password: password)
    }
    
    func displayRegisterSuccess(viewModel: Register2.Register.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        SignOutManager.shared.signOut {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func displayErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

// MARK: Setup & Configuration

extension Register2ViewController {
    private func configure() {
        Register2Configuration.shared.configure(self)
    }
}
