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
   
   
    func getMovieDetailsByID() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .tv_series_season, id: movieId, seasonNumber: nil, expecting: MovieSeason.self)
            .sink(receiveCompletion: { [weak self] (completion) in
                if case let .failure(error) = completion {
                    self?.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.movieDetailsData = CombineDataHandler.populateItemFromServer(with: [$0])
                delegate?.configureUIAfterNetworkCall()
            })
            .store(in: &self.subscriptions)
    }
    
    
    
}
