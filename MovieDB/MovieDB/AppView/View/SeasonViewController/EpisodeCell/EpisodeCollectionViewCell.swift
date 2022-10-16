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
    var episode = [Episode]()
    var episodeTitl = [Episode]()
    let viewModel = MoviesEpisodeViewModel()
    var strings = ""
    var movieID = 0
    var currentSeason = 0
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setUpCellWith(movieID: Int, currentSeason: Int) {
       
    }
    
}


