//
//  GameItem.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation
import RealmSwift

class GameItem: Object, Decodable {
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id:        Int = 0
    @objc dynamic var slug:      String = ""
    @objc dynamic var name:      String = ""
    @objc dynamic var mainImage: String? = nil
    @objc dynamic var gameInfo:  String? = nil
    @objc dynamic var released:  String? = nil
    @objc dynamic var rating:    Double = 0
    
    @objc dynamic var releaseYear: Int {
        guard let date = released else { return 0 }
        let yearString = String(date.prefix(4))
        return Int(yearString) ?? 0
    }
    
    let platforms = List<String>()
    let genres    = List<String>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case background_image
        case description
        case released
        case genres
        case rating
        case platforms
        case developers
    }
    
    enum PlatformCodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try  container.decode(Int.self, forKey: .id)
        name      = try  container.decode(String.self, forKey: .name)
        slug      = try  container.decode(String.self, forKey: .slug)
        mainImage = try? container.decode(String.self, forKey: .background_image)
        gameInfo  = try? container.decode(String.self, forKey: .description)
        released  = try? container.decode(String.self, forKey: .released)
        rating    = try  container.decode(Double.self, forKey: .rating)
        
        let genreList     = try container.decode([Genre].self, forKey: .genres)
        
        let platformList = try container.decode([Platforms].self, forKey: .platforms)
        let arrayOfStrings = platformList.compactMap{ $0.platform.name }
        platforms.append(objectsIn: arrayOfStrings)
        
        
        genres.append(objectsIn: genreList.compactMap { $0.name })
        
        super.init()
    }
    
    required init() {
        super.init()
    }
}

class Platforms: Codable {
    let platform: Platform
}

class Platform: Object, Codable {
    @objc dynamic var name: String?
}

class Genre: Object, Codable {
    @objc dynamic var name: String?
}

class Rating: Object, Codable {
    @objc dynamic var title: String
    @objc dynamic var count: Int
    @objc dynamic var percent: Float
}



