//
//  GameItem.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

struct GameItem: Codable {
    
    let id: Int
    let slug: String
    let name: String
    let background_image: String?
    let description: String?
    let genres: [Genre]
    let released: String?
    let rating: Double
  //  let parent_platforms: [Platform]
    let developers: [Developer]?
    let ratings: [Rating]?
    
}

struct Genre: Codable {
    var name: String?
}

struct Platform: Codable {
    var name: String?
}

struct Developer: Codable {
    var name: String?
    var games_count: Int?
    var image_background: String?
}

struct Rating: Codable {
    var title: String
    var count: Int
    var percent: Float
}



