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
    let background_image: String
    let description: String?
    let genres: [Genre]
    
}

struct Genre: Codable {
    var name: String
}

