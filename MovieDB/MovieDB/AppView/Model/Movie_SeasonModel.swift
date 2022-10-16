//
//  Movie_SeasonModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import Foundation

// MARK: - Welcome
struct MovieSeason: Codable {
    let backdropPath: String?
    let firstAirDate: String?
    let createdBy: [CreatedBy]
    let id: Int?
    let name: String?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let seasons: [Season]
    let voteAverage: Double?
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let name: String
}


// MARK: - TEpisodeToAir
struct TEpisodeToAir: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name, overview: String?
    let seasonNumber, showID: Int?
    let voteAverage, voteCount: Int?
}

// MARK: - Season
struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview: String?
    let seasonNumber: Int?
}

