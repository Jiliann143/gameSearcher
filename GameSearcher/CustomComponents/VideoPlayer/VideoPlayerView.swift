//
//  PlayerContainerView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/21/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import AVKit
import Swiftools

protocol VideoPlayerViewDelegate: class {
    func videoPlayerDidStartPlaying()
    func videoPlayerDidPausePlaying()
}

class VideoPlayerView: UIView {
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var player: AVPlayer? {
        get { return playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    var playerLayer: AVPlayerLayer {
        let playerLayer = layer as! AVPlayerLayer
        playerLayer.videoGravity = .resizeAspectFill
        return playerLayer
    }
    
    private var url: String = ""
    private weak var delegate: VideoPlayerViewDelegate?
    
    func setupPlayer(with url: String, delegate: VideoPlayerViewDelegate?) {
        self.url = url
        self.delegate = delegate
        backgroundColor = .black
        if let url = URL(string: url) {
            player = AVPlayer(url: url)
        }
    }
    
    func playVideo() {
        play()
    }
    
    func pauseVideo() {
        pause()
    }
    
    func videoSliderDidChangeValue(_ value: Float) {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime)
        }
    }
    
    private func play() {
        player?.play()
        delegate?.videoPlayerDidStartPlaying()
    }
    
    private func pause() {
        player?.pause()
        delegate?.videoPlayerDidPausePlaying()
    }
    
    func cleanView() {
        player = nil
    }
}
