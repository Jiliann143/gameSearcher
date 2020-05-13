//
//  HeaderView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/9/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    func setup(_ title: String) -> Self {
        sectionTitle.text = title
        return self
    }
}
