//
//  WebViewController.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import WebKit

protocol WebDisplayLogic: AnyObject {
    func displayLoadWeb(viewModel: Web.LoadWeb.ViewModel)
    func displayShareWeb(viewModel: Web.ShareWeb.ViewModel)
}

class WebViewController: UIViewController, WebDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: WebBusinessLogic?
    var router: (NSObjectProtocol & WebRoutingLogic & WebDataPassing)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak private var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }
    
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
        loadWeb()
    }
    
    // MARK: - IBAction
    
    @IBAction private func dismissPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
   
    @IBAction private func sharePressed(_ sender: UIButton) {
        interactor?.shareWeb(request: Web.ShareWeb.Request())
    }
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = WebInteractor()
        let presenter = WebPresenter()
        let router = WebRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Call Interactor
    
    private func loadWeb() {
        let request = Web.LoadWeb.Request()
        interactor?.loadWeb(request: request)
    }
    
    private func shareWeb() {
        let request = Web.ShareWeb.Request()
        interactor?.shareWeb(request: request)
    }
    
    // MARK: - Display
    
    func displayLoadWeb(viewModel: Web.LoadWeb.ViewModel) {
        DispatchQueue.main.async {
            let url = URL(string: viewModel.mangaData?.url ?? "")!
            self.wkWebView.load(URLRequest(url: url))
        }
    }
    
    func displayShareWeb(viewModel: Web.ShareWeb.ViewModel) {
        let items = [URL(string: viewModel.mangaData?.url ?? "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ProgressHUDManager.shared.showProgress(view: wkWebView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUDManager.shared.dismissProgress()
    }
}
