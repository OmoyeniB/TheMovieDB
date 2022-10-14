//
//  UIView+Extensions.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit
import SDWebImage

extension UIView {
    
    func downloadImage(with url: URL, images: UIImageView){
        images.sd_imageIndicator = SDWebImageActivityIndicator.gray
        images.sd_setImage(with: url) { (image, error, cache, urls) in
                    if (error != nil) {
                        images.image = UIImage(named: "placeholderr")
                    } else {
                        DispatchQueue.main.async {
                            images.image = image
                        }
                    }
        }
    }
    
    func setTopCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
    
}



