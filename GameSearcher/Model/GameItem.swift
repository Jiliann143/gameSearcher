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
    
    @objc dynamic var id: Int = 0
    @objc dynamic var slug: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var background_image: String? = nil
    @objc dynamic var game_description: String? = nil
    @objc dynamic var released: String? = nil
    @objc dynamic var rating: Double = 0
    
    let genres = List<Genre>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case background_image
        case description
        case released
        case genres
        case rating
    }
    
    required init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        id               = try container.decode(Int.self, forKey: .id)
        name             = try container.decode(String.self, forKey: .name)
        slug             = try container.decode(String.self, forKey: .slug)
        background_image = try? container.decode(String.self, forKey: .background_image)
        game_description = try? container.decode(String.self, forKey: .description)
        released         = try? container.decode(String.self, forKey: .released)
        rating           = try container.decode(Double.self, forKey: .rating)
        let genreList    = try container.decode([Genre].self, forKey: .genres)
        genres.append(objectsIn: genreList)
        super.init()
    }
    
    required init() {
        super.init()
    }
    
  //  let parent_platforms: [Platform]
    //    let developers = List<Developer>()
  //  @objc dynamic var developers: [Developer]?
//    @objc dynamic var ratings: [Rating]?
    
}

class Genre: Object, Decodable {
    
    @objc dynamic var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

class Platform: Object, Codable {
    @objc dynamic var name: String?
}

class Developer: Object, Codable {
    @objc dynamic var devName: String?
    @objc dynamic var games_count: Int
    @objc dynamic var image_background: String?
    
}

class Rating: Object, Codable {
    @objc dynamic var title: String
    @objc dynamic var count: Int
    @objc dynamic var percent: Float
}



