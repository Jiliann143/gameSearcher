//
//  TrailerCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class TrailerCell: UICollectionViewCell {

    @IBOutlet weak var videoPlayerView: GameTrailerView!
    private var trailer: Trailer!
    
    func setup(_ trailer: Trailer) -> Self {
        self.trailer = trailer
        videoPlayerView.setupPlayer(with: trailer.videoUrl!)
        return self
    }
}
