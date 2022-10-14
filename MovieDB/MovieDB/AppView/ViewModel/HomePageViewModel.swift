//
//  HomePageViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

protocol TransferData: AnyObject {
    func completionHandler(_ model: [[MovieList]])
}

import Foundation
import Combine

class HomePageViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    weak var delegate: TransferData?
    var popularMovieCategories = [MovieList]()
    var top_ratingMovieCategories = [MovieList]()
    lazy var airing_todayMovieCategories = [MovieList]()
    lazy var on_the_airMovieCategories = [MovieList]()
    lazy var allMovieCategoryList = [[MovieList]]()
    
    
    func getPopularMoviesCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .popular)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [unowned self] in self.popularMovieCategories = self.populateItemFromServer(with: $0)
            })
            .store(in: &self.subscriptions)
    }
    
    func getTopRatingMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .top_rated)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [unowned self] in self.top_ratingMovieCategories = self.populateItemFromServer(with: $0)
            })
            .store(in: &self.subscriptions)
    }
    
    func getAiring_todayMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .top_rated)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [unowned self] in self.airing_todayMovieCategories = self.populateItemFromServer(with: $0)
            })
            .store(in: &self.subscriptions)
    }
    
    func geton_the_airMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .on_the_air)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [unowned self] in self.on_the_airMovieCategories = self.populateItemFromServer(with: $0)
            })
            .store(in: &self.subscriptions)
    }
    
    private func populateItemFromServer(with movies: [MovieList]) -> [MovieList] {
        return movies
    }
    
    
    
}
