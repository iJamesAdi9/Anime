//
//  LoginWorker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginWorker {
    func login(_ request: Login.Login.Request, completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        let email: String = request.email
        let password: String = request.password
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                completionHandler(authResult, nil)
            }
        }
    }
    
    func autoLogin(_ request: Login.AutuLogin.Request, completionHandler: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}
