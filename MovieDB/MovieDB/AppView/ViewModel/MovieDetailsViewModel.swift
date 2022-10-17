//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    
    var temp_seasonAndEpisode: [(Int, [Episode])] = []
    var closure: (() -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    weak var delegate: FetchedDataModelDelegate?
    var movieId: Int = 0
    var movieDetailsData = [MovieSeason]()
    @Published var season = [Season]()
    var currentseasonNumber = 0
    var episodes = [Episode]()
    @Published var seasonAndEpisode: [(Int, [Episode])] = []
    var movieCast = [Cast]() {
        didSet {
            closure?()
        }
    }
    
    func getMovieDetailsByID() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .tv_series_season, id: movieId, seasonNumber: nil, expecting: MovieSeason.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.movieDetailsData = CombineDataHandler.populateItemFromServer(with: [$0])
                _ = self.movieDetailsData.map { data in
                    season = data.seasons
                }
                _ = season.map({ seasoncount in
                    currentseasonNumber = seasoncount.seasonNumber ?? 0
                })
                getCastOfMovie()
            })
            .store(in: &self.subscriptions)
    }
    
    func getCastOfMovie() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .series_casts, id: self.movieId, seasonNumber: nil, expecting: CastModel.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.movieCast = CombineDataHandler.populateItemFromServer(with: $0.cast)
                delegate?.getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: currentseasonNumber)
                
            })
            .store(in: &self.subscriptions)
    }
    
    func getEpisdoeOfSeason(_ currentSeasonNumber: Int) {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .tv_series_episode, id: movieId, seasonNumber: currentSeasonNumber, expecting: MovieEpisodeModel.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] data in
                self.temp_seasonAndEpisode.append((currentSeasonNumber, data.episodes))
                if self.season.count == temp_seasonAndEpisode.count {
                    self.seasonAndEpisode = temp_seasonAndEpisode
                }
            })
            .store(in: &self.subscriptions)
    }
    
    func fetchEpisodes() {
        
        for season in season {
            if let season = season.seasonNumber {
                getEpisdoeOfSeason(season)
            }
        }
    }
}
