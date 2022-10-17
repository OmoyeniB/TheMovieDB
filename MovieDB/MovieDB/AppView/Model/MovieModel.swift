//
//  MovieModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation

// MARK: - Welcome
struct MovieData: Codable {
    let page: Int?
    let results: [MovieList]
    let totalPages, totalResults: Int?
}

// MARK: - Result
struct MovieList: Codable, Equatable {
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let voteAverage: Double?
    let poster_path: String?
    let firstAirDate: String?
    let name: String?
    let vote_average: String?
    
    var isfavorited: Bool?
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? poster_path ?? "")")!
    }
}

struct FavoriteMovieList {
    
    let id: Int?
    let overview: String?
    let posterPath: String?
    let releaseDate, title: String?
    let voteAverage: Double?
    let firstAirDate: String?
    let name: String?
    let vote_average: String?
    
    var isfavorited: Bool?
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
