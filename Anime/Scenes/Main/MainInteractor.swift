//
//  MainInteractor.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func fetchManga(request: Main.FetchManga.Request)
    func saveManga(request: Main.SaveManga.Request)
    func readManga(request: Main.ReadManga.Request)
    func deleteManga(request: Main.DeleteManga.Request)
}

protocol MainDataStore {
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker: MainWorker? = MainWorker()
    
    // MARK: Do something
    
    func fetchManga(request: Main.FetchManga.Request) {
        let search = request.search ?? ""
        
        worker?.fetchManga(search, completionHandler: { [weak self] (dataResponse) in
            guard let self = self else { return }
            switch dataResponse.result {
                case .success(let mangaData):
                    let response = Main.FetchManga.Response(data: mangaData, error: nil)
                    self.presenter?.presentFetchManga(response: response)
                case .failure(let error):
                    let response = Main.FetchManga.Response(data: nil, error: error)
                    self.presenter?.presentFetchManga(response: response)
            }
        })
    }
    
    func saveManga(request: Main.SaveManga.Request) {
        guard let manga = request.manga else { return }
        worker?.saveManga(manga, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                let response = Main.SaveManga.Response(isSuccess: false, error: error)
                self.presenter?.presentSaveManga(response: response)
            } else {
                let response = Main.SaveManga.Response(isSuccess: true, error: nil)
                self.presenter?.presentSaveManga(response: response)
            }
        })
    }
    
    func readManga(request: Main.ReadManga.Request) {
        worker?.readManga(completionHandler: { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                let response = Main.ReadManga.Response(mangaData: request.mangaData, data: nil, error: error)
                self.presenter?.presentReadManga(response: response)
            } else {
                let response = Main.ReadManga.Response(mangaData: request.mangaData, data: querySnapshot, error: nil)
                self.presenter?.presentReadManga(response: response)
            }
        })
    }
    
    func deleteManga(request: Main.DeleteManga.Request) {
        guard let manga = request.manga else { return }
        worker?.deleteManga(manga, completionHandler: { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                let response = Main.DeleteManga.Response(isSuccess: false, error: error)
                self.presenter?.presentDeleteManga(response: response)
            } else {
                let response = Main.DeleteManga.Response(isSuccess: true, error: nil)
                self.presenter?.presentDeleteManga(response: response)
            }
        })
    }
}
