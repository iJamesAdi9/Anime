//
//  MainViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 3/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayFetchMangaSuccess(viewModel: Main.FetchManga.ViewModel)
    func displayFetchMangaFailure(viewModel: Main.FetchManga.ViewModel)
    
    func displaySaveMangaSuccess(viewModel: Main.SaveManga.ViewModel)
    func displaySaveMangaFailure(viewModel: Main.SaveManga.ViewModel)
    
    func displayReadManagaSuccess(viewModel: Main.ReadManga.ViewModel)
    func displayReadManagaFailure(viewModel: Main.ReadManga.ViewModel)
    
    func displayDeleteManagaSuccess(viewModel: Main.DeleteManga.ViewModel)
    func displayDeleteManagaFailure(viewModel: Main.DeleteManga.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private let mainCell: String = "MainCell"
    private var mangaData: [Main.Manga.MangaData]?
    private var favoriteManga: [Main.Manga.MangaData]?
    
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
        fetchManga()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: mainCell, for: indexPath) as? MainCell else { return UITableViewCell() }
        
        let defaultData = Main.Manga.MangaData(malID: 0, images: nil, title: "", score: 0.0, synopsis: "")
        let data = mangaData?[indexPath.row] ?? defaultData
        cell.setupManga(data: data)
        
        cell.favoritePressed = { (mangaData) in
            (mangaData.isFavorite == false) ? self.saveManaga(mangaData: mangaData) : self.deleteManga(mangaData: mangaData)
        }
        
        return cell
    }
    
    // MARK: - Call Interactor
    
    private func fetchManga(search: String? = "naruto") {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.FetchManga.Request(search: search)
        interactor?.fetchManga(request: request)
    }
    
    private func saveManaga(mangaData: Main.Manga.MangaData) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.SaveManga.Request(manga: mangaData)
        interactor?.saveManga(request: request)
    }
    
    private func readManga() {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.ReadManga.Request(mangaData: mangaData)
        interactor?.readManga(request: request)
    }
    
    private func deleteManga(mangaData: Main.Manga.MangaData) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.DeleteManga.Request(manga: mangaData)
        interactor?.deleteManga(request: request)
    }
    
    // MARK: - Display
    
    func displayFetchMangaSuccess(viewModel: Main.FetchManga.ViewModel) {
        mangaData = viewModel.data
        readManga()
    }
    
    func displayFetchMangaFailure(viewModel: Main.FetchManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displaySaveMangaSuccess(viewModel: Main.SaveManga.ViewModel) {
        fetchManga()
    }
    
    func displaySaveMangaFailure(viewModel: Main.SaveManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displayReadManagaSuccess(viewModel: Main.ReadManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        mangaData = viewModel.mangaData
        favoriteManga = viewModel.favoriteManga
        tableView.reloadData()
    }
    
    func displayReadManagaFailure(viewModel: Main.ReadManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displayDeleteManagaSuccess(viewModel: Main.DeleteManga.ViewModel) {
        fetchManga()
    }
    
    func displayDeleteManagaFailure(viewModel: Main.DeleteManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
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

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mangaData = mangaData else {
            let color: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
            let font: UIFont = UIFont.systemFont(ofSize: 16.0)
            tableView.setEmptyMessage(message: "No data found.", textColor: color, font: font)
            return 0
        }
        tableView.resetBackground()
        return mangaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
