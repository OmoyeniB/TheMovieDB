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
    
    var season = [Episode]() {
        didSet {
            episodeCollectionView.reloadData()
        }
    }
    var seasonHeaderTitleCount: [Int] = [Int]()
    var currentSeasonIndex = 0
    var currentSeason = 0
    
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        episodeCollectionView.prefetchDataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUpCollectionView() {
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        episodeCollectionView.registerNib(EpisodeCollectionViewCell.self)
    }
    
    func setUpCellWith( with season: [Episode]) {
        self.season = season
    }
    
}


extension MovieSeasonTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return season.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(EpisodeCollectionViewCell.self, for: indexPath)
        cell.setUpCellWith(episode: season[indexPath.item])
        
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

extension MovieSeasonTableViewCell: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let filteredRow = indexPaths.filter{$0.row >= season.count - 1}
        if filteredRow.count > 1 {
           _ = season.count + 1
        }
        filteredRow.forEach({ _ in
          _ = self.season
        })
    }
}
