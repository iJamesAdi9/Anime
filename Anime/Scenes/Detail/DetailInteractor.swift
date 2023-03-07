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
}
