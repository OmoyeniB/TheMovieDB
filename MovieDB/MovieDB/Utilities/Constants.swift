//
//  Constants.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit

enum Constants {
    
    enum Colors {
        static let algaeGreen = UIColor(named: "AlgaeGreenColor")
        static let almostBlackColor = UIColor(named: "AlmostBlackColor")
        static let battleshipGreyColor = UIColor(named: "BattleshipGreyColor")
        static let dark85Color = UIColor(named: "Dark85Color")
        static let darkColor = UIColor(named: "DarkColor")
        static let greenBlueColor = UIColor(named: "GreenBlueColor")
        static let lightGreyColor = UIColor(named: "LightGreyColor")
        static let slateGreyColor = UIColor(named: "SlateGreyColor")
        static let whiteColor = UIColor(named: "WhiteColor")
        static let deepskyblueColor = UIColor(named: "DeepskyblueColor")
        static let coralColor = UIColor(named: "CoralColor")
    }
    
    enum Images {
        static let homePageNavigationImage = "list.bullet"
    }
    
    enum Fonts {
        static let sf_pro_bold = "SFProText-Bold"
        static let sf_pro_medium = "SFProText-Medium"
        static let sf_pro_regular = "SFProText-Regular"
    }
    
    enum ApiParameter {
        static let apiKey = "b9fd3c0c458976b0ccced6820b43e561"
        static let baseURL = "https://api.themoviedb.org/3"
    }
    
    enum PopUpAlertString {
        static let popUpTitle = "Alert"
        static let popUpActionTitles = "OK"
        static let networkOutOfCoverage = "Oops!.. something went wrong. Please check your connection and try again"
        static let popUpAlertTitle = "Reset Timer?"
        static let popUpAlertActionTitle = "Yes"
        
    }
}

