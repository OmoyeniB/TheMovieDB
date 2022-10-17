//
//  File.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 17/10/2022.
//

import Foundation

extension Date {
    
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        return dateFormatterPrint.string(from: date!);
    }
}
