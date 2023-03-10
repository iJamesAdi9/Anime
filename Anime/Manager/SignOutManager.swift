//
//  SignOutManager.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 4/3/2566 BE.
//

import FirebaseAuth

class SignOutManager {
    static let shared = SignOutManager()
    
    private init() {}
    
    func signOut(_ completionHandler: @escaping () -> ()) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completionHandler()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
