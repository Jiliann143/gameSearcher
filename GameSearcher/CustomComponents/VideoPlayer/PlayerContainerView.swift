//
//  PlayerContainerView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/21/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import AVKit

protocol PlayerContainerViewDelegate {
    func didPressPlay()
    func didPresPause()
    func didUseSlider()
}

class PlayerContainerView: UIView {
    
    @IBOutlet weak var controlsStackView: UIStackView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    private var player = AVPlayer()
    var delegate: PlayerContainerViewDelegate?
    
    static func instanceFromNib(player: AVPlayer, delegate: PlayerContainerViewDelegate) -> PlayerContainerView {
        let view = UINib(nibName: "PlayerContainerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PlayerContainerView
        view.player = player
        view.delegate = delegate
        return view
    }
    
    convenience init(frame: CGRect, player: AVPlayer) {
        self.init(frame: frame)
        self.player = player
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func didPressPlayPauseButton(_ sender: UIButton) {
        handlePlayPauseUI()
        player.timeControlStatus == .playing ? delegate?.didPresPause() : delegate?.didPressPlay()
    }
    
    private func handlePlayPauseUI() {
        player.timeControlStatus == .playing ? playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal) : playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    @IBAction func didDragSlider(_ sender: UISlider) {
        delegate?.didUseSlider()
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player.seek(to: seekTime)
        }
    }
}
