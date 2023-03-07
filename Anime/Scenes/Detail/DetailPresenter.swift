//
//  DetailPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentSetupData(response: Detail.SetupData.Response)
    func presentOpenWebView(response: Detail.OpenWebView.Response)
}

class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSetupData(response: Detail.SetupData.Response) {
        let isFavorite = response.mangaData?.isFavorite ?? false
        let title = (isFavorite) ? "UnFavorite" : "Favorite"
        guard let image = (isFavorite) ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill") else { return }
        
        let viewModel = Detail.SetupData.ViewModel(mangaData: response.mangaData, titleButton: title, imageButton: image)
        viewController?.displaySetupData(viewModel: viewModel)
    }
    
    func presentOpenWebView(response: Detail.OpenWebView.Response) {
        let viewModel = Detail.OpenWebView.ViewModel(mangaData: response.mangaData)
        viewController?.displayOpenWebView(viewModel: viewModel)
    }
}
