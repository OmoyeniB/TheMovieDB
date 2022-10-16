//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import Foundation

final class MovieDetailsViewModel {
    
    var movieId: Int = 0
    var dataFromServer = [MovieList]()
//    https://api.themoviedb.org/3/tv/1418?api_key=b9fd3c0c458976b0ccced6820b43e561&language=en-US
    func getMovieDetailsByID() {
       
//        NetworkManagerRepository.shared.networkRequest(from: .top_rated, id:  movieId)
//            .sink(receiveCompletion: { [weak self] (completion) in
//                if case let .failure(error) = completion {
//                    self?.delegate?.displayAlertOnError(error: error)
//                }
//            }, receiveValue: { [unowned self] in self.top_ratingMovieCategories = self.populateItemFromServer(with: $0)
//            })
//            .store(in: &self.subscriptions)
    }
    
}
