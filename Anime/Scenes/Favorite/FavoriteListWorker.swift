//
//  FavoriteListWorker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavoriteListWorker {
    func fetchFavoriteList(completionHandler: @escaping (_ querySnapshot: QuerySnapshot?, _ error: Error?) -> ()) {
        let email = Auth.auth().currentUser?.email ?? ""
        let db = Firestore.firestore()
        let collectionRef = db.collection("users").document(email).collection("Manga")
        
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let snapshot = snapshot else { return }
                completionHandler(snapshot, nil)
            }
        }
    }
}
