//
//  PersistenceStoreRespository.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 19/10/2022.
//

import Foundation
import RealmSwift

final class PersistenceStoreRespository: PersistenceStore {
    
    fileprivate let configuration = Realm.Configuration()
    fileprivate let realm = try! Realm()
    
    func save<T: Object>(items: T) {
        do {
            try realm.write({
                realm.add(items)
                
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData<T: Object>( type: T.Type) -> [T] {
        Array(realm.objects(type))
    }
    
    func updateIsLiked(liked: Bool, model: FavouriteBookObject) {
        do {
            try! realm.write({
                model.isLiked = liked
            })
        }
    }
    
    func deleteItemFromObject<T: Object>(items: T) {
        do {
            try realm.write({
                realm.delete(items)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
