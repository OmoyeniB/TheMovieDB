//
//  MovieEndPointHandler.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation

enum ApiEndPointHandler: String, CaseIterable {
    
    case popular = "tv/popular"
    case top_rated = "tv/top_rated"
    case airing_today = "tv/airing_today"
    case on_the_air = "tv/on_the_air"
    case tv_series_season = "tv/"
    case tv_series_episode = "/tv/"
    
   public var description: String {
        switch self {
        case .popular: return "popular"
        case .top_rated: return "top_rated"
        case .airing_today: return "airing_today"
        case .on_the_air: return "on_the_air"
        case .tv_series_season: return "total_tv_season"
        case .tv_series_episode: return "series_episode"
        }
    }
    
//    public init?(index: Int) {
//        switch index {
//        case 0: self = .popular
//        case 1: self = .top_rated
//        case 2: self = .airing_today
//        case 3: self = .on_the_air
//        default: return nil
//        }
//    }
    
    public init?(description: String) {
        guard let first = ApiEndPointHandler.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
}
