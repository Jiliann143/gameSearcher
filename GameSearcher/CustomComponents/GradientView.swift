//
//  GradientView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/29/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    func setupGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor,UIColor(white: 50, alpha: 0.5).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.frame
        layer.insertSublayer(gradient, at: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
}
