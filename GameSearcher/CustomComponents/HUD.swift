//
//  HUD.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/29/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import NVActivityIndicatorView

class HUD {
    
    static let w = UIScreen.main.bounds.width
    static let h = UIScreen.main.bounds.height
    
    static let frame = CGRect(origin: CGPoint(x: w/2, y: h/2), size: CGSize(width: 100, height: 100))
    
    static private let hud = NVActivityIndicatorView(frame: frame,
                                                     type: .pacman,
                                                     color: .orange)
    
    static func show() {
        hud.startAnimating()
    }
    
    static func hide() {
        hud.stopAnimating()
    }
}
