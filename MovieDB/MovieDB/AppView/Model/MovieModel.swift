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

struct TVList: Codable {
    let poster_path: String?
    let first_air_date: String?
    let name: String?
    let overview: String?
    let vote_average: String?
    let id: Int?
    let voteAverage: Double?
}

// MARK: - Welcome
struct MovieSeason {
    let createdBy: [CreatedBy]
    let firstAirDate: String
    let id: Int
    let lastAirDate: String
    let lastEpisodeToAir: TEpisodeToAir
    let name: String
    let numberOfEpisodes, numberOfSeasons: Int
    let overview: String
    let posterPath: String
    let seasons: [Season]
    let voteAverage: Double
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
}

// MARK: - CreatedBy
struct CreatedBy {
    let id: Int
    let creditID, name: String
    let gender: Int
    let profilePath: String
}

// MARK: - TEpisodeToAir
struct TEpisodeToAir {
    let airDate: String
    let episodeNumber, id: Int
    let name, overview: String
    let runtime, seasonNumber, showID: Int
    let stillPath: String
    let voteAverage: Double
}

// MARK: - Season
struct Season {
    let airDate: String
    let episodeCount, id: Int
    let name, overview, posterPath: String
    let seasonNumber: Int
}
