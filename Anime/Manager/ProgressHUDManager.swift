//
//  ProgressHUDManager.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 2/3/2566 BE.
//

import JGProgressHUD

class ProgressHUDManager {
    static let shared = ProgressHUDManager()
    
    private let hud = JGProgressHUD(style: .dark)
    
    private init() {}
    
    func showProgress(view: UIView) {
        DispatchQueue.main.async {
            self.hud.textLabel.text = "Loading"
            self.hud.show(in: view)
        }
    }
    
    func dismissProgress() {
        DispatchQueue.main.async {
            self.hud.dismiss()
        }
    }
}
