//
//  FavoritePersistenceStore+Protocol.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 19/10/2022.
//

import Foundation
import RealmSwift

protocol PersistenceStore {
    func save<T: Object>(items: T)
    func fetchData<T: Object>( type: T.Type) -> [T]
    func updateIsLiked(liked: Bool, model: FavouriteBookObject)
    func deleteItemFromObject<T: Object>(items: T)
}

