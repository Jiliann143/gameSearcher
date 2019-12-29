//
//  CodableStructs.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/29/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let results: [GameItem]
}

struct Screenshots: Codable {
    let results: [Screenshot]
}

struct Screenshot: Codable {
    let image: String
}

