//
//  TableViewSectionHeader.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import UIKit
import SnapKit

class TableViewSectionHeader: UITableViewHeaderFooterView {
    
    static let identifier = "Header"
    var seasonHeaderTitleCount: [Int] = [Int]()
    lazy var sectionHeader: UILabel = {
        var sectionHeader = UILabel()
        sectionHeader.text = ""
        sectionHeader.textColor = Constants.Colors.algaeGreen
        sectionHeader.font = UIFont(name: Constants.Fonts.sf_pro_bold, size: 18)
        return sectionHeader
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sectionHeader)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        sectionHeader.snp.makeConstraints({ make in
            make.left.equalTo(contentView).offset(20)
            make.top.bottom.equalTo(contentView)
        })
    }
    
    func setUpSectionHeaderView(with seasonHeaderTitleCount: Season) {
        sectionHeader.text = "Season \((seasonHeaderTitleCount.seasonNumber ?? 0) + 1)"
    }
    
}
