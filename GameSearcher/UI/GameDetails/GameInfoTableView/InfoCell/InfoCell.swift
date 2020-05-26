//
//  InfoCellTableViewCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/10/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(_ type: GameInfo, _ description: String) -> Self {
        titleLabel.text = type.rawValue
        descriptionLabel.text = description
        return self
    }
    
}
