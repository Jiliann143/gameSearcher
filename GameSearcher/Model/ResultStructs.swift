//
//  CodableStructs.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/29/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import Foundation
import RealmSwift

class TrailerResults: Decodable {
    let results: [Trailer]
}

class SearchResults: Decodable {
    let results: [GameItem]
}

struct ScreenshotResults: Codable {
    let results: [Screenshot]
}


