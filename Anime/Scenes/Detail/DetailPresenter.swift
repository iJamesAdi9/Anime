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
}

class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSetupData(response: Detail.SetupData.Response) {
        let viewModel = Detail.SetupData.ViewModel(mangaData: response.mangaData)
        viewController?.displaySetupData(viewModel: viewModel)
    }
}
