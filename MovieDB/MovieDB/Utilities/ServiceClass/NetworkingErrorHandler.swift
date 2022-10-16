//
//  NetworkingErrorHandler.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation

enum NetworkingError: LocalizedError {
    case errorDecoding(DecodingError)
    case unknownError
    case invalid_Url(URLError)
    case serverResponse(Int)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown error"
        case .invalid_Url:
            return "Please provide a valid URL"
        case .serverResponse(let error):
            return "\(error)"
        }
    }
}
