//
//  MovieSeasonViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import UIKit

protocol PassData: AnyObject {
    func totalEpisodeForCurrentSeason(season: [Episode])
}

class MovieSeasonViewController: UIViewController {
    
    weak var delegate: PassData?
    var viewModel = MoviesEpisodeViewModel()
    var movieID = 0
    var seasonNumber = 0
    var currentSeasonNumber = 0
    var seasonHeaderTitleCount: [Int] = [Int]()
    var season_episode: (([Episode]) -> Void)?
    var episode = [Episode]()
    
    @IBOutlet weak var movieSeasonTableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
    }
    
    func configureTableView() {
        movieSeasonTableView.dataSource = self
        movieSeasonTableView.delegate = self
        movieSeasonTableView.register(MovieSeasonTableViewCell.self, forNib: true)
        movieSeasonTableView.rowHeight = 160
        movieSeasonTableView.registerHeaderFooterView(TableViewSectionHeader.self, forNib: false)
        trimTableviewHeader(movieSeasonTableView)
    }
    
}

extension MovieSeasonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return [seasonNumber].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasonNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReuseableCell(MovieSeasonTableViewCell.self, at: indexPath) {
            
            cell.setUpCellWith(movieID: movieID, with: seasonNumber, seasonHeaderTitleCount: seasonHeaderTitleCount, section: indexPath.section, episode: viewModel.episodes)
            viewModel.movieId = movieID
            viewModel.seasonNumber = indexPath.section + 1
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueHeaderFooterView(TableViewSectionHeader.self)
        header?.seasonHeaderTitleCount = seasonHeaderTitleCount
         header?.setUpSectionHeaderView(with: seasonNumber, seasonHeaderTitleCount: seasonHeaderTitleCount, section: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.clear
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .clear
    }
    
    
}


extension MovieSeasonViewController: FetchedDataModelDelegate {
    
    func getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: Int) {

        DispatchQueue.main.async {[weak self] in
            self?.movieSeasonTableView.reloadData()
        }
    }
    

    func errorNotifier(_ error: Error) {
        print(error)
    }

    func configureUIAfterNetworkCall() {
        viewModel.getSeriesEpisodeById_SeasonNumber()
    }


}
