//
//  ProfileViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 16/10/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    var favoriteData = [RealmFavoritedModelObjects]() {
        didSet {
           favoriteData = setUpFavoriedData()
        }
    }
    var persistedData = FetchFavoritedDataFromRealm().data
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        favoriteCollectionView.backgroundColor = .red
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    lazy var navTitle: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont(name: Constants.Fonts.sf_pro_bold, size: 24)
        label.textColor = Constants.Colors.algaeGreen
        return label
    }()
    
    func setUpNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navTitle)
    }
    
    func configureView() {
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
        favoriteCollectionView.register(TVShowCollectionViewCell.self, forCellWithReuseIdentifier: TVShowCollectionViewCell.identifier)
    }
    
    func setUpFavoriedData() -> [RealmFavoritedModelObjects] {
        for persistedDatum in persistedData {
            if persistedDatum.isLiked == true {
                if !favoriteData.contains(where: { $0.id == persistedDatum.id}) {
                    favoriteData.append(persistedDatum)
                }
            } else {
            }
        }
        return favoriteData
    }
   
}


extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.identifier, for: indexPath) as? TVShowCollectionViewCell
        cell?.backgroundColor = .yellow
        return cell ?? UICollectionViewCell()
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionView.frame.size.height / 1.7)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5, left: 5, bottom: 5, right: 5
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
