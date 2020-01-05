//
//  CustomViewPageControl.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 1/5/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class PageIndicatorView: UIStackView {
    
    @IBInspectable var currentPageColor: UIColor = .yellow {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var inactivePageColor: UIColor = UIColor(white: 3, alpha: 0.1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            for _ in 0...numberOfPages - 1 {
                createBarView()
            }
            self.isHidden = hideForSinglePage && numberOfPages <= 1
            arrangedSubviews.first?.backgroundColor = currentPageColor
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            guard currentPage <= numberOfPages - 1 else { return }
            arrangedSubviews.forEach { $0.backgroundColor = inactivePageColor }
            arrangedSubviews[currentPage].backgroundColor = currentPageColor
            layoutIfNeeded()
        }
    }
    
    var hideForSinglePage: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createBarView() {
        let barView = UIView()
        barView.backgroundColor = UIColor(white: 3, alpha: 0.1)
        barView.layer.cornerRadius = 4
        barView.layer.masksToBounds = true
        addArrangedSubview(barView)
    }
}
