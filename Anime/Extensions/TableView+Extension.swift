//
//  TableView+Extension.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 5/3/2566 BE.
//

import UIKit

extension UITableView {
    func setEmptyMessage(message: String, textColor: UIColor, font: UIFont) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = font
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func resetBackground() {
        self.backgroundView = nil
    }
}
