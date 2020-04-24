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
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    func setup(_ trailer: Trailer) -> Self {
        titleLabel.text = trailer.name
        if let url = URL(string: trailer.preview!) {
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(with: url)
        }
        playerView.setupPlayer(with: trailer.videoUrl!, delegate: self)
        return self
    }
    
    func stopVideo() {
        playerView.pauseVideo()
    }
    
    private func reset() {
        thumbnailImageView.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.cleanView()
        reset()
    }
    
}

extension TestTableViewCell: VideoPlayerViewDelegate {
    
    func videoPlayerDidStartPlaying() {
        thumbnailImageView.isHidden = true
    }
    
    func videoPlayerDidPausePlaying() {

    }
}
