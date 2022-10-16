//
//  MoviesEpisodeViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import Foundation
import Combine

final class MoviesEpisodeViewModel {

    private var subscriptions = Set<AnyCancellable>()
    weak var delegate: FetchedDataModelDelegate?
    var movieId: Int = 0
    var seasonNumber: Int = 0
    var episodes = [Episode]()

    func getSeriesEpisodeById_SeasonNumber() {
        NetworkManagerRepository.shared.getSeriesEpisode(from: .tv_series_episode, id: movieId, seasonNumber: seasonNumber)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.episodes = CombineDataHandler.populateItemFromServer(with: $0.episodes)
                delegate?.configureUIAfterNetworkCall()
            })
            .store(in: &self.subscriptions)
    }
}
