//
//  MainModels.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Main {
    
    // MARK: Use cases
    
    struct FetchManga {
        struct Request {
            let search: String?
        }
        
        struct Response {
            let data: Manga?
            let error: Error?
        }
        
        struct ViewModel {
            let data: [Manga.MangaData]?
            let error: Error?
        }
    }
    
    struct SaveManga {
        struct Request {
            let manga: Manga.MangaData?
        }
        
        struct Response {
            let isSuccess: Bool?
            let error: Error?
        }
        
        struct ViewModel {
            let isSuccess: Bool?
            let error: Error?
        }
    }
    
    struct ReadManga {
        struct Request {
            let mangaData: [Manga.MangaData]?
        }
        
        struct Response {
            let mangaData: [Manga.MangaData]?
            let data: QuerySnapshot?
            let error: Error?
        }
        
        struct ViewModel {
            let mangaData: [Manga.MangaData]?
            let favoriteManga: [Manga.MangaData]?
            let error: Error?
        }
    }
    
    struct DeleteManga {
        struct Request {
            let manga: Manga.MangaData?
        }
        
        struct Response {
            let isSuccess: Bool?
            let error: Error?
        }
        
        struct ViewModel {
            let isSuccess: Bool?
            let error: Error?
        }
    }
    
    // MARK: - Manga
    struct Manga: Codable {
        var data: [MangaData]?
        
        struct MangaData: Codable {
            let malID: Int?
            let images: Images?
            let title: String?
            let score: Double?
            let synopsis: String?
            var imageUrl: String?
            var isFavorite: Bool? = false
            
            enum CodingKeys: String, CodingKey {
                case malID = "mal_id"
                case images, title, score, synopsis
                case imageUrl
                case isFavorite
            }
            
            struct Images: Codable {
                let jpg: Jpg?
            }
            
            struct Jpg: Codable {
                let imageURL, smallImageURL, largeImageURL: String?
                
                enum CodingKeys: String, CodingKey {
                    case imageURL = "image_url"
                    case smallImageURL = "small_image_url"
                    case largeImageURL = "large_image_url"
                }
            }
            
            func toDictionary() -> [String: Any] {
                return ["malID": malID ?? 0, "images": imageUrl ?? "", "title": title ?? "", "score": score ?? 0.0, "synopsis": synopsis ?? ""]
            }
        }
    }
}
