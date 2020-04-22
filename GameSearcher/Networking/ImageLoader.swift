//
//  ImageLoader.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/22/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import Foundation
import Kingfisher

class ImageLoader {
    
    static func retrieveImage(with url: String) -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        var image: UIImage?
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { result in
            image = try? result.get().image
        }
        return image
    }
}
