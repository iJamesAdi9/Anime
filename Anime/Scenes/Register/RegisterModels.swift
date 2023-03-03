//
//  RegisterModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

struct Register {
    
    // MARK: Use cases
    
    struct CheckPasswordsMatch {
        struct Request {
            let password: String
            let confirmPassword: String
        }
        
        struct Response {
            let isMatch: Bool
        }
        
        struct ViewModel {
            let message: String
        }
    }
    
    struct Register {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            let result: AuthDataResult?
            let error: Error?
        }
        
        struct ViewModel {
            let result: AuthDataResult?
            let error: Error?
        }
    }
}
