//
//  NetworkClass.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation
import Combine

final class NetworkManagerRepository: MovieService {
    
    public static let shared = NetworkManagerRepository()
    private init () {}
    private let apiKey = Constants.ApiParameter.apiKey
    private let baseAPIURL = Constants.ApiParameter.baseURL
    private let urlSession = URLSession.shared
    private var subscriptions = Set<AnyCancellable>()
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    func getMovieByCategorieEndpoints<T: Codable>(from endpoint: ApiEndPointHandler, id: Int?, seasonNumber: Int?, expecting: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            guard let url = self.getUrlByEndPoint(with: endpoint, id: id, seasonNumber: seasonNumber) else {
                
                return promise(.failure(NetworkingError.invalid_Url))
            }
            
            self.urlSession.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkingError.serverResponse((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return data
                }
                .decode(type: T.self, decoder: self.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.subscriptions)
        }
    }
    
    func getUrlByEndPoint(with endpoint: ApiEndPointHandler, id: Int?, seasonNumber: Int?) -> URL? {
        if endpoint == .tv_series_season {
            guard let urlComponents = URLComponents(string: "\(baseAPIURL)/\(endpoint.rawValue)\(id ?? 0)") else {
                return nil
            }
            return queryUrlComponents(urlComponents: urlComponents)
        } else if endpoint == .series_casts {
            guard let urlComponents = URLComponents(string: "\(baseAPIURL)\(endpoint.rawValue)/\(id ?? 0)/credits") else {
                return nil
            }
            return queryUrlComponents(urlComponents: urlComponents)
            
        } else if endpoint == .tv_series_episode{

            guard let urlComponents = URLComponents(string: "\(baseAPIURL)\(endpoint.rawValue)/\(id ?? 0)/season/\(seasonNumber ?? 0)") else {
                return nil
            }
            return queryUrlComponents(urlComponents: urlComponents)
            
        }
        else {
            guard let urlComponents = URLComponents(string: "\(baseAPIURL)/\(endpoint.rawValue)") else {
                return nil
            }
            return queryUrlComponents(urlComponents: urlComponents)
        }
    }
    
    func queryUrlComponents(urlComponents: URLComponents) -> URL? {
        var urlComponents = urlComponents
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
}


