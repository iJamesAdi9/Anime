//
//  DetailWorker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DetailWorker {
    func saveManga(_ data: Main.Manga.MangaData, completionHandler: @escaping (_ error: Error?) -> ()) {
        let email = Auth.auth().currentUser?.email ?? ""
        let db = Firestore.firestore()
        
        let newData = Main.Manga.MangaData(malID: data.malID, url: data.url, images: data.images, title: data.title, score: data.score, synopsis: data.synopsis, imageUrl: data.imageUrl)
        
        db.collection("users").document(email).collection("Manga").document("malID_\(newData.malID ?? 0)").setData(newData.toDictionary()) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func deleteManga(_ data: Main.Manga.MangaData, completionHandler: @escaping (_ error: Error?) -> ()) {
        let email = Auth.auth().currentUser?.email ?? ""
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(email).collection("Manga").document("malID_\(data.malID ?? 0)")
        
        docRef.delete { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
}
