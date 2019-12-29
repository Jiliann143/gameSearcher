//
//  GameCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher

class GameCell: UITableViewCell {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameGenre: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setupGameInfo(_ game: GameItem) {
        gameTitle.text = game.name
        
        let arrayOfNames = game.genres.map{ $0.name }
        gameGenre.text = arrayOfNames.joined(separator: ", ")
        
        guard let url = URL(string: game.background_image) else {return}
            gameImageView.kf.indicatorType = .activity
            gameImageView.kf.setImage(with: url)
       
    }

    func setupCellUI() {
        selectionStyle = .none
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
    }
}
