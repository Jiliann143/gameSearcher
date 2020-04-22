//
//  TestTableViewCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/21/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var playerView: VideoPlayerView!
    
    private var trailer: Trailer!
    
    func setup(_ trailer: Trailer) -> Self {
        self.trailer = trailer
        playerView.setupPlayer(with: trailer.videoUrl!, previewImage: trailer.previewImage)
        return self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.cleanView()
    }
    
}
