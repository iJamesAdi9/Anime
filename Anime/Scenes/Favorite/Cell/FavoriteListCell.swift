//
//  FavoriteListCell.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 7/3/2566 BE.
//

import UIKit
import Kingfisher

class FavoriteListCell: UITableViewCell {
    
    @IBOutlet weak private var animeImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!

    // MARK: - init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    // MARK: - General function
    
    private func clear() {
        animeImageView.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
    }
    
    func setupFavoriteList(data: Main.Manga.MangaData) {
        let urlImage = data.imageUrl ?? ""
        let title = data.title ?? ""
        let detail = data.synopsis ?? ""
        
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: URL(string: urlImage))
        titleLabel.text = title
        detailLabel.text = detail
    }
}
