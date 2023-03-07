//
//  WebPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WebPresentationLogic {
    func presentLoadWeb(response: Web.LoadWeb.Response)
    func presentShareWeb(response: Web.ShareWeb.Response)
}

class WebPresenter: WebPresentationLogic {
    weak var viewController: WebDisplayLogic?
    
    // MARK: Do something
    
    func presentLoadWeb(response: Web.LoadWeb.Response) {
        let viewModel = Web.LoadWeb.ViewModel(mangaData: response.mangaData)
        viewController?.displayLoadWeb(viewModel: viewModel)
    }
    
    func presentShareWeb(response: Web.ShareWeb.Response) {
        let viewModel = Web.ShareWeb.ViewModel(mangaData: response.mangaData)
        viewController?.displayShareWeb(viewModel: viewModel)
    }
}
