//
//  Register2Models.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Register2 {
    struct Register {
        struct Request{
            let email: String
            let password: String
        }
        
        struct Response{
            let error: Error?
        }
        
        struct ViewModel{
            let error: Error?
        }
    }
    
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
}
