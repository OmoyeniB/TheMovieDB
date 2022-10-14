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
    
    func setNavbarOpacity() {
        navigationController?.navigationBar.backgroundColor = .clear
        let transperentBlackColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.75)
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        transperentBlackColor.setFill()
        UIRectFill(rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
        UIGraphicsEndImageContext()
    }
    
    public func popUpAlert(title: String, message: String, alertStyle: UIAlertController.Style,
                           actionTitles: [String], actionStyles: [UIAlertAction.Style],
                           actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle,
                                       style: actionStyles[index],
                                       handler: actions[index])
            
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true)
    }
    
    public func displayError(error: String) {
        
        DispatchQueue.main.async {
            self.popUpAlert(title: Constants.PopUpAlertString.popUpTitle,
                            message: error,
                            alertStyle: .alert,
                            actionTitles: [Constants.PopUpAlertString.popUpActionTitles], actionStyles: [.default], actions: [ { _ in
            }])
        }
        
    }
}

