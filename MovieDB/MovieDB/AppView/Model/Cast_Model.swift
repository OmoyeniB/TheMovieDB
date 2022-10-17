//
//  CastModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 16/10/2022.
//

import Foundation

struct CastModel: Codable {
    let cast: [Cast]
    let id: Int
}

// MARK: - Cast
struct Cast: Codable {
    let name: String?
    let profilePath: String?
    let order: Int
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}
