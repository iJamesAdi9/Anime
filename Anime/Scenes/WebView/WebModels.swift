//
//  WebModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Web {
    
    // MARK: Use cases
    
    struct LoadWeb {
        struct Request {
        }
        
        struct Response {
            let mangaData: Main.Manga.MangaData?
        }
        
        struct ViewModel {
            let mangaData: Main.Manga.MangaData?
        }
    }
    
    struct ShareWeb {
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
