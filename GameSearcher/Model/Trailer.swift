//
//  Trailer.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation
import RealmSwift
import Swiftools
import Kingfisher

class Trailer: Object, Decodable {
    
    @objc dynamic var id:        Int = 0
    @objc dynamic var name:      String = ""
    @objc dynamic var preview:   String? = nil
    @objc dynamic var videoUrl:  String? = nil
 //   let videoUrls = List<String>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case preview
        case data
    }
    
    enum VideoDataCodingKeys: String, CodingKey {
        case medium = "480"
        case fullHD = "max"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id        = try  container.decode(Int.self, forKey: .id)
        name      = try  container.decode(String.self, forKey: .name)
        preview   = try  container.decode(String.self, forKey: .preview)
        
        let nestedContainer = try container.nestedContainer(keyedBy: VideoDataCodingKeys.self, forKey: .data)
        videoUrl = try nestedContainer.decode(String.self, forKey: .medium)
   //     videoUrls.append(arrayOfUrls)
        
        super.init()
    }
    
    required init() {
        super.init()
    }
}

extension Trailer {
    
    var previewImage: UIImage? {
        guard let url = preview else { return nil }
        return ImageLoader.retrieveImage(with: url)
    }
}
