//
//  File.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 17/10/2022.
//

import Foundation

extension Date {
    
    static func getFormattedDate(string: String , formatter: String) -> String{
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = formatter
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"
        
        let showDate = inputFormatter.date(from: string)
        let resultString = outputFormatter.string(from: showDate!)
        
        return resultString
    }
}
