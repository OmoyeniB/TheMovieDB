//
//  TVShowCollectionViewCell.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit
//import Kingfisher


class TVShowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TVShowCollectionViewCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var movieDetails: UITextView!
    @IBOutlet weak var movieRatings: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initiateSetUp()
    }
    
    func initiateSetUp() {
        movieImage.setTopCornerRadius()
        movieImage.addShadowToImageView()
    }
    
    func setUpCell(with movieData: MovieList) {
        self.downloadImage(with: movieData.imageURL, images: movieImage)
        movieTitle.text = movieData.name
        movieDetails.text = movieData.overview
        releasedDate.text = movieData.firstAirDate
        movieRatings.setTitle(String(movieData.voteAverage ?? 0.0), for: .normal)
    }
    
    @IBAction func ratingsAction(_ sender: Any) {
    }
    
    
   
}


