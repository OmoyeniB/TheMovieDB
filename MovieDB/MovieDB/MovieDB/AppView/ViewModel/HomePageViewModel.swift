//
//  HomePageViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

protocol FetchedDataModelDelegate: AnyObject {
    func errorNotifier(_ error: Error)
    func configureUIAfterNetworkCall()
}

import Foundation
import Combine

class HomePageViewModel {
    
    private var subscriptions = Set<AnyCancellable>()
    weak var delegate: FetchedDataModelDelegate?
    var popularMovieCategories = [MovieList]()
    var top_ratingMovieCategories = [MovieList]()
    lazy var airing_todayMovieCategories = [MovieList]()
    lazy var on_the_airMovieCategories = [MovieList]()
    lazy var allMovieCategoryList = [[MovieList]]()
    
    
    func getPopularMoviesCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .popular)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.popularMovieCategories = CombineDataHandler.populateItemFromServer(with: $0)
                getTopRatingMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func getTopRatingMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .top_rated)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.top_ratingMovieCategories = CombineDataHandler.populateItemFromServer(with: $0)
                getAiring_todayMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func getAiring_todayMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .airing_today)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.airing_todayMovieCategories = CombineDataHandler.populateItemFromServer(with: $0)
                geton_the_airMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func geton_the_airMovieCategories() {
        NetworkManagerRepository.shared.networkRequest(from: .on_the_air)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.on_the_airMovieCategories = CombineDataHandler.populateItemFromServer(with: $0)
                delegate?.configureUIAfterNetworkCall()
            })
            .store(in: &self.subscriptions)
        
    }
    
   
  
}

