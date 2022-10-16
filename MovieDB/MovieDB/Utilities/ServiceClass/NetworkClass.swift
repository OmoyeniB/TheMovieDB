//
//  NetworkClass.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation
import Combine

final class NetworkManagerRepository: MovieService {
  
//    func networkRequest<T>(from endpoint: ApiEndPointHandler) -> Future<[T], NetworkingError> {
//        <#code#>
//    }
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
    
    func networkRequest(from endpoint: ApiEndPointHandler) -> Future<[MovieList], NetworkingError> {
        
        return Future<[MovieList], NetworkingError> { promise in
            guard let url = self.getUrlByEndPoint(with: endpoint) else {
                return promise(.failure(.invalid_Url(URLError(URLError.unsupportedURL))))
            }
            
            self.urlSession.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkingError.serverResponse((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return data
                }
                .decode(type: MovieData.self, decoder: self.jsonDecoder)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.invalid_Url(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.errorDecoding(decodingError)))
                        case let apiError as NetworkingError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(.unknownError))
                        }
                    }
                }, receiveValue: { promise(.success($0.results)) })
                .store(in: &self.subscriptions)
        }
    }
    
    func getUrlByEndPoint(with endpoint: ApiEndPointHandler) -> URL? {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/\(endpoint.rawValue)") else {
            return nil
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
}

//https://api.themoviedb.org/3/movie/popular?api_key=b9fd3c0c458976b0ccced6820b43e561
//https://api.themoviedb.org/3/movie/top_rated?api_key=b9fd3c0c458976b0ccced6820b43e561
//https://api.themoviedb.org/3/tv/airing_today?api_key=b9fd3c0c458976b0ccced6820b43e561&language=en-US&page=1
//https://api.themoviedb.org/3/tv/on_the_air?api_key=b9fd3c0c458976b0ccced6820b43e561&language=en-US&page=1
