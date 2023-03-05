//
//  MainWorker.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
import FirebaseFirestore

class MainWorker {
    private let END_POINT = "https://api.jikan.moe/v4/anime?q="
    private let httpClient: HttpClient
    
    init(client: HttpClient = HttpClient()) {
        self.httpClient = client
    }
    
    func fetchManga(_ search: String, completionHandler: @escaping(DataResponse<Main.Manga, AFError>) -> ()) {
        let url = "\(END_POINT)\(search)"
        httpClient.request(url, method: .get, of: Main.Manga.self, completionHandler: completionHandler)
    }
    
    func saveManga(_ data: Main.Manga.MangaData, completionHandler: @escaping (_ error: Error?) -> ()) {
        let email = Auth.auth().currentUser?.email ?? ""
        let db = Firestore.firestore()
        
        let newData = Main.Manga.MangaData(malID: data.malID, images: data.images, title: data.title, score: data.score, synopsis: data.synopsis, imageUrl: data.imageUrl)
        
        db.collection("users").document(email).collection("Manga").document("malID_\(newData.malID ?? 0)").setData(newData.toDictionary()) { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func readManga(completionHandler: @escaping (_ querySnapshot: QuerySnapshot?, _ error: Error?) -> ()) {
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
