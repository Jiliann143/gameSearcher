//
//  RealmService.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/1/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import RealmSwift
import Foundation
import Swiftools

class RealmService {
    
    private init() {}
        
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func get<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
        
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
            Log("Succesfully added")
        } catch {
            LogError(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            LogError(error)
        }
    }
    
}
