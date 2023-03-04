//
//  MainCell.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 5/3/2566 BE.
//

import UIKit

class MainCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - IBAction
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        
    }
}
