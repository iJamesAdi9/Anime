//
//  LoginModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

struct Login {
    
    // MARK: Use cases
    
    struct Login {
        
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
    
    struct AutuLogin {
        struct Request {
        }
        
        struct Response {
            let isSignedIn: Bool
        }
        
        struct ViewModel {
            let isSignedIn: Bool
        }
    }
}
