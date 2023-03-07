//
//  WebInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WebBusinessLogic {
    func loadWeb(request: Web.LoadWeb.Request)
    func shareWeb(request: Web.ShareWeb.Request)
}

protocol WebDataStore {
    var mangaData: Main.Manga.MangaData? { get set }
}

class WebInteractor: WebBusinessLogic, WebDataStore {
    var presenter: WebPresentationLogic?
    var worker: WebWorker? = WebWorker()
    var mangaData: Main.Manga.MangaData?
    
    // MARK: Do something
    
    func loadWeb(request: Web.LoadWeb.Request) {
        let response = Web.LoadWeb.Response(mangaData: mangaData)
        presenter?.presentLoadWeb(response: response)
    }
    
    func shareWeb(request: Web.ShareWeb.Request) {
        let response = Web.ShareWeb.Response(mangaData: mangaData)
        presenter?.presentShareWeb(response: response)
    }
}
