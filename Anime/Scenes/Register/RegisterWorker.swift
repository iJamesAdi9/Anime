//
//  RegisterWorker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterWorker {
    func register(_ request: Register.Register.Request, completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        let email: String = request.email
        let password: String = request.password
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                completionHandler(authResult, nil)
            }
        }
    }
}
