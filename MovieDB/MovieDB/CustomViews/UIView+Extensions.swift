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
    
    func defaultTextForOverView(text: UITextView, dataText: MovieList) {
        if dataText.overview == nil || dataText.overview == "" {
            DispatchQueue.main.async {
                text.text = "Ooop no overview was provided for this"
            }
        } else {
            DispatchQueue.main.async {
                text.text = dataText.overview
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
    
    
}



