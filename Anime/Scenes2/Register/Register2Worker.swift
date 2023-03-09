//
//  Register2Worker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

class Register2Worker: Register2WorkerProtocol {
    func register(_ request: Register2.Register.Request, completionHandler: @escaping (Error?) -> ()) {
        let email: String = request.email
        let password: String = request.password
        
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
}
