//
//  MainPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentFetchManga(response: Main.FetchManga.Response)
    func presentReadManga(response: Main.ReadManga.Response)
    func presentSaveManga(response: Main.SaveManga.Response)
    func presentDeleteManga(response: Main.DeleteManga.Response)
    func presentFilteredManga(response: Main.FilterManga.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentFetchManga(response: Main.FetchManga.Response) {
        guard let data = response.data?.data else {
            let viewModel = Main.FetchManga.ViewModel(data: nil, error: response.error)
            viewController?.displayFetchMangaFailure(viewModel: viewModel)
            return
        }
        
        let newData = data.map { Main.Manga.MangaData(malID: $0.malID, images: $0.images, title: $0.title, score: $0.score, synopsis: $0.synopsis, imageUrl: $0.images?.jpg?.imageURL) }
        
        let viewModel = Main.FetchManga.ViewModel(data: newData, error: nil)
        viewController?.displayFetchMangaSuccess(viewModel: viewModel)
    }
    
    func presentReadManga(response: Main.ReadManga.Response) {
        guard let snapShot = response.data, var originalMangaData = response.originalMangaData, var displayMangaData = response.displayMangaData else {
            let viewModel = Main.ReadManga.ViewModel(originalMangaData: response.originalMangaData, displayMangaData: nil, favoriteManga: nil, error: response.error)
            viewController?.displayReadMangaFailure(viewModel: viewModel)
            return
        }
        
        let favoriteManga = snapShot.documents.compactMap { $0.data() }.compactMap {
            Main.Manga.MangaData(malID: $0["malID"] as? Int,
                                 images: nil,
                                 title: $0["title"] as? String,
                                 score: $0["score"] as? Double,
                                 synopsis: $0["synopsis"] as? String,
                                 imageUrl: $0["images"] as? String)
        }
        
//        let malID = favoriteManga.map { $0.malID ?? 0 }
//        mangaData.indices.filter { malID.contains(mangaData[$0].malID ?? 0) }.forEach { (index) in
//            mangaData[index].isFavorite = true
//        }
        
        let malID = favoriteManga.map { $0.malID ?? 0 }
        displayMangaData.indices.forEach { displayMangaData[$0].isFavorite = malID.contains(displayMangaData[$0].malID ?? 0) }
        originalMangaData.indices.forEach { originalMangaData[$0].isFavorite = malID.contains(originalMangaData[$0].malID ?? 0) }
        
        let viewModel = Main.ReadManga.ViewModel(originalMangaData: originalMangaData, displayMangaData: displayMangaData, favoriteManga: favoriteManga, error: nil)
        viewController?.displayReadMangaSuccess(viewModel: viewModel)
    }
    
    func presentSaveManga(response: Main.SaveManga.Response) {
        guard let isSuccess = response.isSuccess else {
            let viewModel = Main.SaveManga.ViewModel(manga: response.manga, isSuccess: false, error: response.error)
            viewController?.displaySaveMangaFailure(viewModel: viewModel)
            return
        }
        
        let viewModel = Main.SaveManga.ViewModel(manga: response.manga, isSuccess: isSuccess, error: nil)
        viewController?.displaySaveMangaSuccess(viewModel: viewModel)
    }
    
    func presentDeleteManga(response: Main.DeleteManga.Response) {
        guard let isSuccess = response.isSuccess else {
            let viewModel = Main.DeleteManga.ViewModel(manga: response.manga, isSuccess: false, error: response.error)
            viewController?.displayDeleteMangaFailure(viewModel: viewModel)
            return
        }
        
        let viewModel = Main.DeleteManga.ViewModel(manga: response.manga, isSuccess: isSuccess, error: nil)
        viewController?.displayDeleteMangaSuccess(viewModel: viewModel)
    }
    
    func presentFilteredManga(response: Main.FilterManga.Response) {
        let mangaData = response.mangaData ?? []
        
        if mangaData.isEmpty {
            let viewModel = Main.FilterManga.ViewModel(mangaData: nil)
            viewController?.displayFilteredMangaFailure(viewModel: viewModel)
        } else {
            let viewModel = Main.FilterManga.ViewModel(mangaData: mangaData)
            viewController?.displayFilteredMangaSuccess(viewModel: viewModel)
        }
    }
    
}
