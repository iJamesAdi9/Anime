//
//  MainPresenter.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentSomething(response: Main.Something.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Main.Something.Response) {
        let viewModel = Main.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
