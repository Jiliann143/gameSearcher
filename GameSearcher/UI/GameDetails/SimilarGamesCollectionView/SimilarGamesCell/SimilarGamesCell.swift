//
//  SimilarGamesCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class SimilarGamesCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupGame(_ game: GameItem) -> Self {
        gameTitleLabel.text = game.name
        
        if let image = game.mainImage, let url = URL(string: image) {
            gameImageView.kf.setImage(with: url)
        } else {
            gameImageView.image = #imageLiteral(resourceName: "testimage")
        }
        
        return self
    }

}
