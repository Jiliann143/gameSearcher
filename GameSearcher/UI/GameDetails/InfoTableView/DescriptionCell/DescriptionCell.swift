//
//  DescriptionCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/10/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

protocol DescriptionCellDelegate: class {
    func needUpdateCellHeight()
}

class DescriptionCell: InfoCell {

    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var descriptionView: UIView!
    
    weak var delegate: DescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapExpandView)))
    }
    
    func setDelegate(_ delegate: DescriptionCellDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    private var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                expandButton.rotateView(360)
                descriptionLabel.numberOfLines = 2
                descriptionLabel.sizeToFit()
                delegate?.needUpdateCellHeight()
            } else {
                expandButton.rotateView(180)
                descriptionLabel.numberOfLines = 0
                descriptionLabel.sizeToFit()
                delegate?.needUpdateCellHeight()
            }
        }
    }
    
    @objc func didTapExpandView(_ sender: UITapGestureRecognizer) {
        isExpanded = !isExpanded
    }
}
