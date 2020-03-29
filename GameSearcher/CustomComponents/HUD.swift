//
//  HUD.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/29/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import NVActivityIndicatorView

class HUD: NVActivityIndicatorViewable {
    
    static private let standardAppearance = ActivityData(size: CGSize(width: 100, height: 100),
                                                  message: nil,
                                                  messageFont: nil,
                                                  messageSpacing: nil,
                                                  type: .pacman,
                                                  color: .green,
                                                  padding: nil,
                                                  displayTimeThreshold: nil,
                                                  minimumDisplayTime: nil,
                                                  backgroundColor: nil,
                                                  textColor: nil)
    
    static func show() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(standardAppearance)
    }
    
    static func hide() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
