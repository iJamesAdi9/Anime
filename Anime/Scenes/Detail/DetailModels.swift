//
//  DetailModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Detail {
    
    // MARK: Use cases
    
    struct SetupData {
        struct Request {
        }
        
        struct Response {
            let mangaData: Main.Manga.MangaData?
        }
        
        struct ViewModel {
            let mangaData: Main.Manga.MangaData?
        }
    }
}
