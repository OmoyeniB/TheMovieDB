//
//  NetworkServiceProtocol.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation
import Combine

protocol MovieService {
    
    func networkRequest(from endpoint: ApiEndPointHandler) -> Future<[MovieList], Error>
    
    //    func networkRequest<T>(from endpoint: ApiEndPointHandler) -> Future<[T], NetworkingError>
    
//    func queryUrlComponents(urlComponents: URLComponents) -> URL?
}
