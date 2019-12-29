//
//  ScreenshotCollectionViewCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/29/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var screenshot: UIImage? {
        didSet {
            imageView.image = screenshot
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
