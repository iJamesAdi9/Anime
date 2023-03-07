//
//  FavoriteListPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoriteListPresentationLogic {
    func presentFavoriteList(response: FavoriteList.FetchFavoriteList.Response)
    func presentDidSelectItem(response: FavoriteList.SelectItem.Response)
}

class FavoriteListPresenter: FavoriteListPresentationLogic {
    weak var viewController: FavoriteListDisplayLogic?
    
    // MARK: Do something
    
    func presentFavoriteList(response: FavoriteList.FetchFavoriteList.Response) {
        let viewModel = FavoriteList.FetchFavoriteList.ViewModel(favoriteList: response.favoriteList, error: response.error)
        viewController?.displayFavoriteList(viewModel: viewModel)
    }
    
    func presentDidSelectItem(response: FavoriteList.SelectItem.Response) {
        viewController?.displayDidSelectItem(viewModel: FavoriteList.SelectItem.ViewModel())
    }
}
