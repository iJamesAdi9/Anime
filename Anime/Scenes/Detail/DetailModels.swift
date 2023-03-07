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
            let titleButton: String
            let imageButton: UIImage
        }
    }
    
    struct OpenWebView {
        struct Request {
        }
        
        struct Response {
            let mangaData: Main.Manga.MangaData?
        }
        
        struct ViewModel {
            let mangaData: Main.Manga.MangaData?
        }
    }
    
    struct SaveManga {
        struct Request {
            let manga: Main.Manga.MangaData?
        }
        
        struct Response {
            let manga: Main.Manga.MangaData?
            let isSuccess: Bool?
            let error: Error?
        }
        
        struct ViewModel {
            let title: String
            let image: UIImage
            let error: Error?
        }
    }
    
    struct DeleteManga {
        struct Request {
            let manga: Main.Manga.MangaData?
        }
        
        struct Response {
            let manga: Main.Manga.MangaData?
            let isSuccess: Bool?
            let error: Error?
        }
        
        struct ViewModel {
            let title: String
            let image: UIImage
            let error: Error?
        }
    }
}
