//
//  FavoritePersistedObjects.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 19/10/2022.
//

import Foundation
import RealmSwift


final class FavouriteBookObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var ratings: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var isLiked: Bool = false
}
