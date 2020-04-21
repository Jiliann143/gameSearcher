//
//  GameTrailerView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Swiftools

class GameTrailerView: UIView {
    
    private var player: AVPlayer!
    private var url: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer(with: url)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlayer(with: url)
    }
    
    func setupPlayer(with url: String) {
        self.url = url
        layoutPlayer()
    }
    
    private func layoutPlayer() {
        backgroundColor = .black
        if let url = URL(string: url) {
            self.player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            layer.addSublayer(playerLayer)
            playerLayer.frame = self.bounds
            let containerView = PlayerContainerView.instanceFromNib(player: player, delegate: self)
            containerView.frame = self.bounds
            self.addSubview(containerView)
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapVideoPlayer)))
    }
    
    @objc private func handleTapVideoPlayer() {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        topmostController.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}

extension GameTrailerView: PlayerContainerViewDelegate {
    
    func didPressPlay() {
        player.play()
    }
    
    func didPresPause() {
        player.pause()
    }
    
    func didUseSlider() {
        LogInfo("SLIDER MOVED")
    }
}

