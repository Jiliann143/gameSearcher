//
//  ScreenshotCollectionViewCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/29/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher

class ScreenshotCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var screenshot: String? {
        didSet {
            imageView.loadImage(screenshot)
        }
    }
    
    func setup(_ screenshot: String?) -> Self {
        self.screenshot = screenshot
        return self
    }
}

