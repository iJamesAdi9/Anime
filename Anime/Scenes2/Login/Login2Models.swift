//
//  Login2Models.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 9/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Login2 {
    struct Login {
        struct Request {
            let email: String?
            let password: String?
        }
        
        struct Response {
        }
        
        struct ViewModel {
            let email: String?
            let password: String?
        }
    }
    
    struct AutoLogin {
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
