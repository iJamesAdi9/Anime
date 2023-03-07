//
//  FavoriteListInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoriteListBusinessLogic {
    func fetchFavoriteList(request: FavoriteList.FetchFavoriteList.Request)
    func didSelectItem(request: FavoriteList.SelectItem.Request)
}

protocol FavoriteListDataStore {
    var favoriteData: Main.Manga.MangaData? { get set }
}

class FavoriteListInteractor: FavoriteListBusinessLogic, FavoriteListDataStore {
    var presenter: FavoriteListPresentationLogic?
    var worker: FavoriteListWorker? = FavoriteListWorker()
    var favoriteData: Main.Manga.MangaData?
    
    // MARK: Do something
    
    func fetchFavoriteList(request: FavoriteList.FetchFavoriteList.Request) {
        worker?.fetchFavoriteList(completionHandler: { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                let response = FavoriteList.FetchFavoriteList.Response(favoriteList: nil, error: error)
                self.presenter?.presentFavoriteList(response: response)
            } else {
                let favoriteList = querySnapshot?.documents.compactMap { $0.data() }.compactMap {
                    Main.Manga.MangaData(malID: $0["malID"] as? Int,
                                         url: $0["url"] as? String,
                                         images: nil,
                                         title: $0["title"] as? String,
                                         score: $0["score"] as? Double,
                                         synopsis: $0["synopsis"] as? String,
                                         imageUrl: $0["images"] as? String)
                }
                
                let response = FavoriteList.FetchFavoriteList.Response(favoriteList: favoriteList, error: nil)
                self.presenter?.presentFavoriteList(response: response)
            }
        })
    }
    
    func didSelectItem(request: FavoriteList.SelectItem.Request) {
        favoriteData = request.favoriteData
        favoriteData?.isFavorite = true
        presenter?.presentDidSelectItem(response: FavoriteList.SelectItem.Response())
    }
}
