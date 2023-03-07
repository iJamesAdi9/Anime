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
    
    func displayReadMangaSuccess(viewModel: Main.ReadManga.ViewModel)
    func displayReadMangaFailure(viewModel: Main.ReadManga.ViewModel)
    
    func displaySaveMangaSuccess(viewModel: Main.SaveManga.ViewModel)
    func displaySaveMangaFailure(viewModel: Main.SaveManga.ViewModel)
    
    func displayDeleteMangaSuccess(viewModel: Main.DeleteManga.ViewModel)
    func displayDeleteMangaFailure(viewModel: Main.DeleteManga.ViewModel)
    
    func displayFilteredMangaSuccess(viewModel: Main.FilterManga.ViewModel)
    func displayFilteredMangaFailure(viewModel: Main.FilterManga.ViewModel)
    
    func displayAlertSearchAnimeSuccess(viewModel: Main.SearchAnime.ViewModel)
    func displayDidSelectItem(viewModel: Main.SelectManga.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private let mainCell: String = "MainCell"
    private let defaultMangaData = Main.Manga.MangaData(malID: 0, url: "", images: nil, title: "", score: 0.0, synopsis: "")
    private var originalMangaData: [Main.Manga.MangaData]?
    private var displayMangaData: [Main.Manga.MangaData]?
    private var favoriteManga: [Main.Manga.MangaData]?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var mangaSearchBar: UISearchBar!
    
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
        if mangaSearchBar.text?.count == 0 {
            fetchManga()
        } else {
            readManga()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction private func searchAnimePressed(_ sender: UIBarButtonItem) {
        interactor?.searchAnime(request: Main.SearchAnime.Request())
    }
    
    @IBAction private func logoutPressed(_ sender: UIButton) {
        ProgressHUDManager.shared.showProgress(view: view)
        SignOutManager.shared.signOut {
            ProgressHUDManager.shared.dismissProgress()
            self.navigationController?.popToRootViewController(animated: true)
        }
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
        
        let data = displayMangaData?[indexPath.row] ?? defaultMangaData
        cell.setupManga(data: data)
        
        cell.favoritePressed = { (mangaData) in
            (mangaData.isFavorite == false) ? self.saveManaga(mangaData: mangaData) : self.deleteManga(mangaData: mangaData)
        }
        
        return cell
    }
    
    private func showAlertWithTextField() {
        let alert = UIAlertController(title: "Anime name", message: "Please enter anime name", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Anime name"
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if let textField = alert.textFields?.first, let text = textField.text {
                self.fetchManga(search: text)
            }
        })

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Call Interactor
    
    private func fetchManga(search: String? = "naruto") {
        ProgressHUDManager.shared.showProgress(view: view)
        DispatchQueue.global(qos: .background).async {
            let request = Main.FetchManga.Request(search: search)
            self.interactor?.fetchManga(request: request)
        }
    }
    
    private func readManga() {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.ReadManga.Request(originalMangaData: originalMangaData, displayMangaData: displayMangaData)
        interactor?.readManga(request: request)
    }
    
    private func saveManaga(mangaData: Main.Manga.MangaData) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.SaveManga.Request(manga: mangaData)
        interactor?.saveManga(request: request)
    }
    
    private func deleteManga(mangaData: Main.Manga.MangaData) {
        ProgressHUDManager.shared.showProgress(view: view)
        let request = Main.DeleteManga.Request(manga: mangaData)
        interactor?.deleteManga(request: request)
    }
    
    private func filterManga(filteredText: String) {
        let mangaData = originalMangaData ?? []
        let request = Main.FilterManga.Request(filteredText: filteredText, mangaData: mangaData)
        interactor?.filterManga(request: request)
    }
    
    // MARK: - Display
    
    func displayFetchMangaSuccess(viewModel: Main.FetchManga.ViewModel) {
        originalMangaData = viewModel.data
        displayMangaData = viewModel.data
        readManga()
    }
    
    func displayFetchMangaFailure(viewModel: Main.FetchManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displayReadMangaSuccess(viewModel: Main.ReadManga.ViewModel) {
        DispatchQueue.global(qos: .background).async {
            self.originalMangaData = viewModel.originalMangaData
            self.displayMangaData = viewModel.displayMangaData
            self.favoriteManga = viewModel.favoriteManga
            
            DispatchQueue.main.async {
                ProgressHUDManager.shared.dismissProgress()
                self.tableView.reloadData()
            }
        }
    }
    
    func displayReadMangaFailure(viewModel: Main.ReadManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displaySaveMangaSuccess(viewModel: Main.SaveManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        readManga()
    }
    
    func displaySaveMangaFailure(viewModel: Main.SaveManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displayDeleteMangaSuccess(viewModel: Main.DeleteManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        readManga()
    }
    
    func displayDeleteMangaFailure(viewModel: Main.DeleteManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        print(viewModel.error?.localizedDescription ?? "")
    }
    
    func displayFilteredMangaSuccess(viewModel: Main.FilterManga.ViewModel) {
        displayMangaData = viewModel.mangaData
        tableView.reloadData()
    }
    
    func displayFilteredMangaFailure(viewModel: Main.FilterManga.ViewModel) {
        displayMangaData = nil
        tableView.reloadData()
    }
    
    func displayAlertSearchAnimeSuccess(viewModel: Main.SearchAnime.ViewModel) {
        showAlertWithTextField()
    }
    
    func displayDidSelectItem(viewModel: Main.SelectManga.ViewModel) {
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

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterManga(filteredText: searchText)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let displayMangaData = displayMangaData else {
            let color: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
            let font: UIFont = UIFont.systemFont(ofSize: 16.0)
            tableView.setEmptyMessage(message: "No data found.", textColor: color, font: font)
            return 0
        }
        tableView.resetBackground()
        return displayMangaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let mangaData = displayMangaData?[indexPath.row] else { return }
        let request = Main.SelectManga.Request(mangaData: mangaData)
        interactor?.didSelectItem(request: request)
    }
}
