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
    
    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var movieDetails: UITextView!
    @IBOutlet weak var movieRatings: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initiateSetUp()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func initiateSetUp() {
        movieImage.setTopCornerRadius()
    }
    
    func setUpCell(with movieData: MovieList) {
        self.downloadImage(with: movieData.imageURL, images: movieImage)
        movieTitle.text = movieData.name
        defaultTextForOverView(text: movieDetails, dataText: movieData)
        DispatchQueue.main.async { [weak self] in
            self?.releasedDate.text = Date.getFormattedDate(string: movieData.firstAirDate ?? "", formatter: "yyyy-MM-dd")
        }
        movieRatings.setTitle(String(movieData.voteAverage ?? 0.0), for: .normal)
    }
    
    @IBAction func ratingsAction(_ sender: Any) {
    }
    
    
}


