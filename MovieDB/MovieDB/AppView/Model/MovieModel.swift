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
struct MovieList: Codable, Equatable, Hashable {
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let voteAverage: Double?
    let poster_path: String?
    let first_air_date: String?
    let name: String?
    let vote_average: String?
   
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? poster_path ?? "")")!
    }
}


enum OriginalLanguage {
    case en
    case fr
    case ja
}

//struct TVList: Codable {
//    let poster_path: String?
//    let first_air_date: String?
//    let name: String?
//    let overview: String?
//    let vote_average: String?
//    let id: Int?
//    let voteAverage: Double?
//}

