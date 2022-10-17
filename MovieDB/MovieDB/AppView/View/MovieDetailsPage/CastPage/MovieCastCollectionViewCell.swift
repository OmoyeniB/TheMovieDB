//
//  MovieCastCollectionViewCell.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 17/10/2022.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCastCollectionViewCell"
    var season = [Episode]()
    
    lazy var actorImage: UIImageView = {
        var actorImage = UIImageView()
        actorImage.contentMode = .scaleAspectFill
        actorImage.clipsToBounds = true
        actorImage.layer.masksToBounds = true
        return actorImage
    }()
    
    lazy var actorName: UILabel = {
        var actorName = UILabel()
        actorName.textAlignment = .center
        actorName.font = UIFont(name: Constants.Fonts.sf_pro_medium, size: 12)
        actorName.textColor = Constants.Colors.whiteColor
        return actorName
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorImage)
        contentView.addSubview(actorName)
        initializeCell()
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        actorImage.image = nil
    }
    
    func initializeCell() {
        actorImage.snp.makeConstraints({ make in
            make.left.equalTo(contentView).offset(5)
            make.height.width.equalTo(frame.size.width)
            
        })
        
        actorName.snp.makeConstraints({ make in
            make.top.equalTo(actorImage.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView)
        })
    }

    func setUpCellWith(_ cast: Cast, season: [Episode]) {
        self.season = season
        actorName.text = cast.name
        downloadImage(with: cast.imageURL, images: actorImage)
    }
    
}
