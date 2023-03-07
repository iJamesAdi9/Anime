//
//  FavoriteListViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavoriteListDisplayLogic: AnyObject {
    func displayFavoriteList(viewModel: FavoriteList.FetchFavoriteList.ViewModel)
    func displayDidSelectItem(viewModel: FavoriteList.SelectItem.ViewModel)
}

class FavoriteListViewController: UIViewController, FavoriteListDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: FavoriteListBusinessLogic?
    var router: (NSObjectProtocol & FavoriteListRoutingLogic & FavoriteListDataPassing)?
    private let favoriteListCell: String = "FavoriteListCell"
    private var favoriteList: [Main.Manga.MangaData]?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteList()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = FavoriteListInteractor()
        let presenter = FavoriteListPresenter()
        let router = FavoriteListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func fetchFavoriteList() {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = FavoriteList.FetchFavoriteList.Request()
        interactor?.fetchFavoriteList(request: request)
    }
    
    // MARK: - Setup Cells
    private func favoriteListAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteListCell, for: indexPath) as? FavoriteListCell else { return UITableViewCell() }
        
        guard let favoriteList = favoriteList?[indexPath.row] else { return UITableViewCell() }
        cell.setupFavoriteList(data: favoriteList)
        
        return cell
    }
    
    // MARK: - Display
    
    func displayFavoriteList(viewModel: FavoriteList.FetchFavoriteList.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        favoriteList = viewModel.favoriteList
        tableView.reloadData()
    }
    
    func displayDidSelectItem(viewModel: FavoriteList.SelectItem.ViewModel) {
        performSegue(withIdentifier: "DetailViewController", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoriteList = favoriteList else {
            let color: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
            let font: UIFont = UIFont.systemFont(ofSize: 16.0)
            tableView.setEmptyMessage(message: "No data found.", textColor: color, font: font)
            return 0
        }
        
        if favoriteList.isEmpty {
            return 0
        } else {
            tableView.resetBackground()
            return favoriteList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return favoriteListAt(indexPath)
    }
}

// MARK: - UITableViewDelegate

extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let favoriteList = favoriteList?[indexPath.row] else { return }
        let request = FavoriteList.SelectItem.Request(favoriteData: favoriteList)
        interactor?.didSelectItem(request: request)
    }
}
