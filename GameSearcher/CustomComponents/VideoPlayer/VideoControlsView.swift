//
//  PlayerContainerView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/21/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import AVKit

protocol VideoControlsDelegate: class {
    func videoDidPressPlay()
    func videoDidPressPause()
    func videoSliderDidChangeValue(_ value: Float)
}

class VideoControlsView: UIView {
    
    @IBOutlet weak var controlsStackView: UIStackView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    private weak var player: AVPlayer?
    private weak var delegate: VideoControlsDelegate?
    
    class func instantiate() -> VideoControlsView {
        let view = UINib(nibName: "VideoControlsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VideoControlsView
        return view
    }
    
    func setup(_ player: AVPlayer, delegate: VideoControlsDelegate) {
        self.delegate = delegate
        self.player = player
    }
    
    func reset() {
        playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
    
    @IBAction func didPressPlayPauseButton(_ sender: UIButton) {
        player?.timeControlStatus == .playing ? playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal) : playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        player?.timeControlStatus == .playing ? delegate?.videoDidPressPause() : delegate?.videoDidPressPlay()
    }
    
    @IBAction func didDragSlider(_ sender: UISlider) {
        delegate?.videoSliderDidChangeValue(sender.value)
    }
}
