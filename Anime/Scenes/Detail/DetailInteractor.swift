//
//  DetailInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
    func setupData(request: Detail.SetupData.Request)
    func openWebView(request: Detail.OpenWebView.Request)
    func favoriteManga()
    func saveManga(request: Detail.SaveManga.Request)
    func deleteManga(request: Detail.DeleteManga.Request)
}

protocol DetailDataStore {
    var mangaData: Main.Manga.MangaData? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker? = DetailWorker()
    var mangaData: Main.Manga.MangaData?
    
    // MARK: Do something
    
    func setupData(request: Detail.SetupData.Request) {
        let response = Detail.SetupData.Response(mangaData: mangaData)
        presenter?.presentSetupData(response: response)
    }
    
    func openWebView(request: Detail.OpenWebView.Request) {
        let response = Detail.OpenWebView.Response(mangaData: mangaData)
        presenter?.presentOpenWebView(response: response)
    }
    
    func favoriteManga() {
        if mangaData?.isFavorite == false {
            let request = Detail.SaveManga.Request(manga: mangaData)
            saveManga(request: request)
        } else {
            let request = Detail.DeleteManga.Request(manga: mangaData)
            deleteManga(request: request)
        }
    }
    
    func saveManga(request: Detail.SaveManga.Request) {
        guard let manga = request.manga else { return }
        worker?.saveManga(manga, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                let response = Detail.SaveManga.Response(manga: manga, isSuccess: false, error: error)
                self.presenter?.presentSaveManga(response: response)
            } else {
                let response = Detail.SaveManga.Response(manga: manga, isSuccess: true, error: nil)
                self.presenter?.presentSaveManga(response: response)
            }
        })
    }
    
    func deleteManga(request: Detail.DeleteManga.Request) {
        guard let manga = request.manga else { return }
        worker?.deleteManga(manga, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                let response = Detail.DeleteManga.Response(manga: manga, isSuccess: false, error: error)
                self.presenter?.presentDeleteManga(response: response)
            } else {
                let response = Detail.DeleteManga.Response(manga: manga, isSuccess: true, error: nil)
                self.presenter?.presentDeleteManga(response: response)
            }
        })
    }
}
