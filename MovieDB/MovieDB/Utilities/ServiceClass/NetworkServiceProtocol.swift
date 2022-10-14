//
//  NetworkServiceProtocol.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation
import Combine

protocol MovieService {
    func networkRequest(from endpoint: ApiEndPointHandler) -> Future<[MovieList], NetworkingError>
    
    func getUrlByEndPoint(with endpoint: ApiEndPointHandler) -> URL?
}
