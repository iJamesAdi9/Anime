//
//  DetailViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 6/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailDisplayLogic: AnyObject {
    func displaySetupData(viewModel: Detail.SetupData.ViewModel)
    func displayOpenWebView(viewModel: Detail.OpenWebView.ViewModel)
    
    func displaySaveMangaSuccess(viewModel: Detail.SaveManga.ViewModel)
    func displaySaveMangaFailure(viewModel: Detail.SaveManga.ViewModel)
    
    func displayDeleteMangaSuccess(viewModel: Detail.DeleteManga.ViewModel)
    func displayDeleteMangaFailure(viewModel: Detail.DeleteManga.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic {
    // MARK: - Properties
    
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var animeImageView: UIImageView!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    
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
        setupData()
    }
    
    // MARK: - IBAction
    
    @IBAction private func webviewPressed(_ sender: UIButton) {
        interactor?.openWebView(request: Detail.OpenWebView.Request())
    }
    
    @IBAction private func favoritePressed(_ sender: UIButton) {
        ProgressHUDManager.shared.showProgress(view: view)
        interactor?.favoriteManga()
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupData() {
        let request = Detail.SetupData.Request()
        interactor?.setupData(request: request)
    }
    
    private func setFavoriteButton(title: String, image: UIImage) {
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.setTitle(title, for: .normal)
    }
    
    // MARK: - Display
    
    func displaySetupData(viewModel: Detail.SetupData.ViewModel) {
        let title = viewModel.mangaData?.title ?? ""
        let detail = viewModel.mangaData?.synopsis ?? ""
        let imageUrl = viewModel.mangaData?.imageUrl ?? ""
        
        titleLabel.text = title
        detailLabel.text = detail
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: URL(string: imageUrl))
        setFavoriteButton(title: viewModel.titleButton, image: viewModel.imageButton)
    }
    
    func displayOpenWebView(viewModel: Detail.OpenWebView.ViewModel) {
        performSegue(withIdentifier: "WebViewController", sender: nil)
    }
    
    func displaySaveMangaSuccess(viewModel: Detail.SaveManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        setFavoriteButton(title: viewModel.title, image: viewModel.image)
    }
    
    func displaySaveMangaFailure(viewModel: Detail.SaveManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        setFavoriteButton(title: viewModel.title, image: viewModel.image)
    }
    
    func displayDeleteMangaSuccess(viewModel: Detail.DeleteManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        setFavoriteButton(title: viewModel.title, image: viewModel.image)
    }
    
    func displayDeleteMangaFailure(viewModel: Detail.DeleteManga.ViewModel) {
        ProgressHUDManager.shared.dismissProgress()
        setFavoriteButton(title: viewModel.title, image: viewModel.image)
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
