//
//  MovieCastCollectionViewCell.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 16/10/2022.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieCastCollectionViewCell"
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        actorImage.image = nil
    }
    
    func setUpCellWith(_ cast: Cast) {
        actorName.text = cast.name
        downloadImage(with: cast.imageURL, images: actorImage)
    }

}
