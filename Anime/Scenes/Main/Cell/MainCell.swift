//
//  MainCell.swift
//  Anime
//
//  Created by Wachiravit Teerasarn on 5/3/2566 BE.
//

import UIKit
import Kingfisher

class MainCell: UITableViewCell {
    
    // MARK: Properties
    
    var favoritePressed: ((Main.Manga.MangaData) -> ())?
    private var mangaData: Main.Manga.MangaData?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    // MARK: - IBAction
    
    @IBAction private func favoritePressed(_ sender: UIButton) {
        guard let mangaData = mangaData else { return }
        favoritePressed?(mangaData)
    }

    // MARK: - General function
    
    private func clear() {
        animeImageView.image = nil
        favoriteButton.setImage(nil, for: .normal)
        titleLabel.text = nil
        detailLabel.text = nil
    }
    
    func setupManga(data: Main.Manga.MangaData) {
        mangaData = data
        
        let urlImage = data.imageUrl ?? ""
        let isFavorite = data.isFavorite ?? false
        let image = (isFavorite) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let title = data.title ?? ""
        let detail = data.synopsis ?? ""
        
        animeImageView.kf.indicatorType = .activity
        animeImageView.kf.setImage(with: URL(string: urlImage))
        favoriteButton.setImage(image, for: .normal)
        titleLabel.text = title
        detailLabel.text = detail
    }
}
