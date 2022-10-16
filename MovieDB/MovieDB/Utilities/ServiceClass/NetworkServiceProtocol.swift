//
//  NetworkServiceProtocol.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation
import Combine

protocol MovieService {
    
    func getMovieByCategorieEndpoints<T: Codable>(from endpoint: ApiEndPointHandler, id: Int?, seasonNumber: Int?, expecting: T.Type) -> Future<T, Error>
    func getUrlByEndPoint(with endpoint: ApiEndPointHandler, id: Int?, seasonNumber: Int?) -> URL?
    func queryUrlComponents(urlComponents: URLComponents) -> URL?
}
