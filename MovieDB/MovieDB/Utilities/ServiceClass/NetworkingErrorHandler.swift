//
//  NetworkingErrorHandler.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation

enum NetworkingError: Error {
    case errorDecoding
    case unknownError
    case invalid_Url
    case serverResponse(Int)
    
 
}
