//
//  TwoStateButton.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/8/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import HelperKit
import Swiftools

@IBDesignable class TwoStateButton: UIButton {
    
    @IBInspectable var selectedTitle:   String = ""
    @IBInspectable var deselectedTitle: String = ""
    
    @IBInspectable var selectedColor:   UIColor = .white
    @IBInspectable var deselectedColor: UIColor = .clear
    
    @IBInspectable var selectedTextColor:   UIColor = .white
    @IBInspectable var deselectedTextColor: UIColor = .white
    
    @IBInspectable var isActive: Bool = false {
        didSet {
            isActive ? setSelected() : setDeselected()
        }
    }
    
    func togle() {
        isActive = !isActive
        LogInfo(isActive)
    }
    
    private func setSelected() {
            self.backgroundColor = self.selectedColor
            self.setTitle(self.selectedTitle, for: .normal)
            self.setTitleColor(self.selectedTextColor, for: .normal)
    }
    
    private func setDeselected() {
            self.backgroundColor = self.deselectedColor
            self.setTitle(self.deselectedTitle, for: .normal)
            self.setTitleColor(self.deselectedTextColor, for: .normal)
    }
}
