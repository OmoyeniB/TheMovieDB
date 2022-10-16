//
//  CustomError.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidData
    case invalidPath
    case emptyInput
    case responseError(Int)
}
