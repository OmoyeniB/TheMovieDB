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
        provideDefaultText(dataToModify: movieData)
        date(dataToModify: movieData)
        movieRatings.setTitle(String(movieData.voteAverage ?? 0.0), for: .normal)
    }
    
    @IBAction func ratingsAction(_ sender: Any) {
    }
    
    
    func provideDefaultText(dataToModify: MovieList) {
        movieTitle.text = dataToModify.title
        movieDetails.text = dataToModify.overview
        
        if dataToModify.name != nil {
            movieTitle.text = dataToModify.name
        }
        
        else if  movieDetails.text == "" {
            movieDetails.text = "Opps No detail provided"
        }
    }
    
    func date(dataToModify: MovieList) {
       
        if dataToModify.releaseDate != nil && dataToModify.first_air_date == nil {
            releasedDate.text = dataToModify.first_air_date
        }
//      else if dataToModify.first_air_date != nil {
            releasedDate.text = dataToModify.first_air_date
//        }
    }
}


