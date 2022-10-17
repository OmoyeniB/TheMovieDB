//
//  MovieEpisodeModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 15/10/2022.
//

import Foundation

// MARK: - Welcome
struct MovieEpisodeModel: Codable {
    let id: Int?
    let episodes: [Episode]
    let name, overview: String?
    let seasonNumber: Int?
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name: String?
    let stillPath: String?
    
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(stillPath ?? "")")!
    }

}
