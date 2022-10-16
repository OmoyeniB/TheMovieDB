//
//  ProfileViewModel.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 16/10/2022.
//

import Foundation

final class ProfileViewModel {
    
    var displayProfileItem: [ProfileModel] {
        return profileTableContents()
    }
    
    func profileTableContents() -> [ProfileModel] {
        return [ProfileModel(title: "What do you want to do?"),
        ProfileModel(title: "View Profile"),
        ProfileModel(title: "Log out"),
        ProfileModel(title: "Cancel")]
    }
}
