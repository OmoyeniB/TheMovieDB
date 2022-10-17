//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    weak var delegate: FetchedDataModelDelegate?
    var movieId: Int = 0
    var movieDetailsData = [MovieSeason]()
    var seasonNumber: Int = 0
    var episodes = [Episode]()
    var movieCast = [Cast]()
    
    func getMovieDetailsByID() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .tv_series_season, id: movieId, seasonNumber: nil, expecting: MovieSeason.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.movieDetailsData = CombineDataHandler.populateItemFromServer(with: [$0])
                _ = self.movieDetailsData.map { data in
                    seasonNumber = data.numberOfSeasons ?? 0
                }
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
                print(self.movieCast, "^^^^^^^^^$$$$$$")
                delegate?.getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: seasonNumber)
            })
            .store(in: &self.subscriptions)
    }
    
    func getSeriesEpisodeById_SeasonNumber() {
        
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .tv_series_episode, id: movieId, seasonNumber: seasonNumber, expecting: MovieEpisodeModel.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.episodes = CombineDataHandler.populateItemFromServer(with: $0.episodes)
                print(episodes, "^^^^^^^^^((((((")
                delegate?.configureUIAfterNetworkCall()
            })
            .store(in: &self.subscriptions)
    }
    
    
}
