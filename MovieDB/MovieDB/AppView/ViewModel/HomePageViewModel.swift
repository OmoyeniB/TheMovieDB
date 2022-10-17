//
//  HomePageViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

protocol FetchedDataModelDelegate: AnyObject {
    func errorNotifier(_ error: Error)
    func configureUIAfterNetworkCall()
    func getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: Int)
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
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .popular, id: nil, seasonNumber: nil, expecting: MovieData.self)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.popularMovieCategories = CombineDataHandler.populateItemFromServer(with: $0.results)
                getTopRatingMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func getTopRatingMovieCategories() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .top_rated, id: nil, seasonNumber: nil, expecting: MovieData.self)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.top_ratingMovieCategories = CombineDataHandler.populateItemFromServer(with: $0.results)
                getAiring_todayMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func getAiring_todayMovieCategories() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .on_the_air, id: nil, seasonNumber: nil, expecting: MovieData.self)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.airing_todayMovieCategories = CombineDataHandler.populateItemFromServer(with: $0.results)
                geton_the_airMovieCategories()
            })
            .store(in: &self.subscriptions)
    }
    
    func geton_the_airMovieCategories() {
        NetworkManagerRepository.shared.getMovieByCategorieEndpoints(from: .airing_today, id: nil, seasonNumber: nil, expecting: MovieData.self)
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.delegate?.errorNotifier(error)
                }
            }, receiveValue: { [unowned self] in self.on_the_airMovieCategories = CombineDataHandler.populateItemFromServer(with: $0.results)
                delegate?.configureUIAfterNetworkCall()
            })
            .store(in: &self.subscriptions)
        
    }
    
   
  
}

