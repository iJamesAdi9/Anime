//
//  FavoriteListModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct FavoriteList {
    
    // MARK: Use cases
    
    struct FetchFavoriteList {
        struct Request {
        }
        
        struct Response {
            let favoriteList: [Main.Manga.MangaData]?
            let error: Error?
        }
        
        struct ViewModel {
            let favoriteList: [Main.Manga.MangaData]?
            let error: Error?
        }
    }
    
    struct SelectItem {
        struct Request {
            var favoriteData: Main.Manga.MangaData?
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
}
