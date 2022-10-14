//
//  UIViewController+Extensions.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit
import SDWebImage

extension UIViewController {
   
    func setUpNavigationTitle(text: String) -> String {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: Constants.Fonts.sf_pro_medium, size: 20)
        label.textColor = Constants.Colors.whiteColor
        return label.text ?? ""
    }

    func setUpNavigationButton(imageName: String) -> String {
        let image = UIImageView()
        image.image = UIImage(systemName: Constants.Images.homePageNavigationImage)
        return imageName
    }
    
    func addCustomButtonInNavigationBar(button: UIButton) -> UIBarButtonItem {
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return menuBarItem
    }
    
}

