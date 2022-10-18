//
//  MovieSeasonViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import UIKit
import Combine

protocol PassData: AnyObject {
    func totalEpisodeForCurrentSeason(season: [Episode])
}

class MovieSeasonViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    weak var delegate: PassData?
    var movieID = 0
    var season = [Season]()
    var currentSeasonNumber = 0
    var episode = [Episode]()
    let movieDetailsViewModel = MovieDetailsViewModel()
    
    @IBOutlet weak var movieSeasonTableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        movieDetailsViewModel.movieId = movieID
        setUpObservers()
        movieDetailsViewModel.getMovieDetailsByID()
    }
    
    func configureTableView() {
        movieSeasonTableView.dataSource = self
        movieSeasonTableView.delegate = self
        movieSeasonTableView.register(MovieSeasonTableViewCell.self, forNib: true)
        movieSeasonTableView.rowHeight = 160
        movieSeasonTableView.registerHeaderFooterView(TableViewSectionHeader.self, forNib: false)
        trimTableviewHeader(movieSeasonTableView)
    }
    
    func setUpObservers() {
        movieDetailsViewModel.$season
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.movieDetailsViewModel.fetchEpisodes()
                
            }.store(in: &cancellables)
        movieDetailsViewModel.$seasonAndEpisode
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.movieSeasonTableView.reloadData()
                
            }.store(in: &cancellables)
    }
    
}

extension MovieSeasonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return [movieDetailsViewModel.$season].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieDetailsViewModel.season.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReuseableCell(MovieSeasonTableViewCell.self, at: indexPath) {
            cell.setUpCellWith(with: movieDetailsViewModel.seasonAndEpisode[indexPath.section].1)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueHeaderFooterView(TableViewSectionHeader.self)
        header?.setUpSectionHeaderView(with: movieDetailsViewModel.season[section])
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
        movieDetailsViewModel.getEpisdoeOfSeason(seasonNumber)
    }
    

    func errorNotifier(_ error: Error) {
        self.displayError(error: error.localizedDescription)
    }

    func configureUIAfterNetworkCall() {
        
    }


}
