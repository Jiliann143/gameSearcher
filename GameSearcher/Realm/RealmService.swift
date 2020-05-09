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
    
    private init() { Log(Realm.Configuration.defaultConfiguration.fileURL) }
        
    static let shared = RealmService()
    
    func commitWriting(action: () -> Void) {
        let realm = try! Realm()
        realm.refresh()
        try? realm.write {
            action()
        }
    }
        
    func objects<T: Object>(_ object: T.Type, predicate: NSPredicate? = nil) -> Results<T> {
        let realm = try! Realm()
        realm.refresh()
        guard let predicate = predicate else { return realm.objects(object) }
        return realm.objects(object).filter(predicate)
    }
    
    func object<T: Object>(_ object: T.Type, key: Int) -> T? {
        let realm = try! Realm()
        realm.refresh()
        return realm.object(ofType: object, forPrimaryKey: key)
    }
    
        
    func append<T: Object>(_ objects: [T]) {
        let realm = try! Realm()
        realm.refresh()
        if realm.isInWriteTransaction {
            realm.add(objects, update: .modified)
        } else {
            try? realm.write {
                realm.add(objects, update: .modified)
            }
        }
    }
    
    func append<T: Object>(_ object: T) {
        append([object])
    }
    
    func delete<T: Object>(_ object: T) {
        let realm = try! Realm()
        realm.refresh()
        
        do {
            try realm.write {
                realm.delete(object)
            }
            Log("Succesfully deleted")
        } catch {
            LogError(error)
        }
    }
    
    
//MARK: - Queries
    
    func getGame(with id: Int) -> Results<GameItem> {
        let realm = try! Realm()
        realm.refresh()
        return realm.objects(GameItem.self).filter("id =\(id)")
    }
    
    func existsInRealm(id: Int) -> Bool {
        object(GameItem.self, key: id) != nil
    }
}


