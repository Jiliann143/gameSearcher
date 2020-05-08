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
    
    var realm = try! Realm()

//MARK: - CRUD
    
    func get<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
        
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
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
            Log("Succesfully deleted")
        } catch {
            LogError(error)
        }
    }
    
//MARK: - Queries
    
    func getGame(with id: Int) -> Results<GameItem> {
        return realm.objects(GameItem.self).filter("id =\(id)")
    }
    
    func gameExists(id: Int) -> Bool {
        !getGame(with: id).isEmpty
    }
    
    
//MARK: - Game Item Operations

    func deleteGame(_ game: GameItem) {
        if let gameForDeletion = realm.object(ofType: GameItem.self, forPrimaryKey: game.id) {
            if gameForDeletion.isInvalidated { return }
            delete(gameForDeletion)
        }
    }

    
}

