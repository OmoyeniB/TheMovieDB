//
//  UISegmentedControl+Extensions.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import UIKit

extension UISegmentedControl {
    
    func adjustFont() {
        let font = UIFont(name: Constants.Fonts.sf_pro_bold, size: 10) ?? UIFont.systemFont(ofSize: 10)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: Constants.Colors.whiteColor as Any]
        self.setTitleTextAttributes(normalAttribute, for: .normal)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: Constants.Colors.whiteColor as Any]
        self.setTitleTextAttributes(selectedAttribute, for: .selected)
    }
}
