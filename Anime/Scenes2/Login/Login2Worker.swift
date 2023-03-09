//
//  Login2Worker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

class Login2Worker: Login2WorkerProtocol {
    func login(_ request: Login2.Login.Request, completionHandler: @escaping (_ error: Error?) -> ()) {
        let email: String = request.email ?? ""
        let password: String = request.password ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func autoLogin(_ request: Login2.AutoLogin.Request, completionHandler: @escaping (_ isSignedIn: Bool?) -> ()) {
        if Auth.auth().currentUser != nil {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}
