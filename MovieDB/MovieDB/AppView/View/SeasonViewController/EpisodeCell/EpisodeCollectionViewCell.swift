//
//  EpisodeCollectionViewCell.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {

    static let identifier = "EpisodeCollectionViewCell"
    var seasonHeaderTitleCount: [Int] = [Int]()
    var strings = ""
    var movieID = 0
    var currentSeason = 0
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeImage.image = nil
        episodeTitle.text = ""
    }
    
    func setUpCellWith(episode: Episode) {
        episodeTitle.text = episode.name
        downloadImage(with: episode.imageURL, images: episodeImage)
    }
    
}


