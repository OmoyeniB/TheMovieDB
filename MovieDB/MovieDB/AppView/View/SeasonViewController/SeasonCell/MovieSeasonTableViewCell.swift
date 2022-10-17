//
//  MovieSeasonTableViewCell.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import UIKit

class MovieSeasonTableViewCell: UITableViewCell {
    
    var movieID = 0
    var seasonNumber = 0
    static let identifier = "MovieSeasonTableViewCell"
    var episode = [Episode]() {
        didSet {
            
        }
    }
    var seasonHeaderTitleCount: [Int] = [Int]()
    var currentSeasonIndex = 0
    var currentSeason = 0
    var vc = MovieSeasonViewController()
    
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.episodeCollectionView.contentView = nil
    }

    func setUpCollectionView() {
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        episodeCollectionView.registerNib(EpisodeCollectionViewCell.self)
    }
    
    func setUpCellWith(
        movieID: Int,
        with numberOfSection: Int,
        seasonHeaderTitleCount: [Int],
        section: Int,
        episode: [Episode]
    ) {
         // 4
        //1
        //2
        //3
        //4
        self.episode = episode
//        print(episode, "((((((((((___")
        self.episodeCollectionView.reloadData()
    }
    
}


extension MovieSeasonTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(EpisodeCollectionViewCell.self, for: indexPath)
        cell.setUpCellWith(episode: episode[indexPath.item])
//        self.episodeCollectionView.reloadData()
        return cell
    }
    
    
}

extension MovieSeasonTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.height - padding
        
        return CGSize(width: collectionView.frame.size.width / 1.7, height:  collectionViewSize )
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5, left: 20, bottom: 5, right: 20
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 46
    }
    
}

