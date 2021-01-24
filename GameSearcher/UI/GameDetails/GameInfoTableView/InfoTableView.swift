//
//  InfoTableView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/10/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import Swiftools
import HelperKit

enum GameInfo: String {
    case genre       = "Genre"
    case released    = "Released"
    case platforms   = "Platforms"
    case developer   = "Developer"
    case description = "Description"
}

class InfoTableView: DynamicTableView, UITableViewDelegate, UITableViewDataSource {
    
    private var game: GameItem!
    
    func setup(_ game: GameItem) {
        self.game = game
        delegate = self
        dataSource = self
        registerCell(InfoCell.self)
        registerCell(DescriptionCell.self)
        rowHeight = UITableView.automaticDimension
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.cell(InfoCell.self).setup(.genre, game.genres.joined(separator: ", "))
        case 1:
            return tableView.cell(InfoCell.self).setup(.released, game.released.anyString)
        case 2:
            return tableView.cell(InfoCell.self).setup(.platforms, game.platforms.compactMap{ $0 }.joined(separator: ", "))
        case 3:
            return tableView.cell(InfoCell.self).setup(.developer, "coming soon")
        case 4:
            return tableView.cell(DescriptionCell.self).setDelegate(self).setup(.description, game.gameInfo.anyString.stripHTML ?? "")
        default:
            return UITableViewCell()
        }
    }
}

extension InfoTableView: DescriptionCellDelegate {
    
    func needUpdateCellHeight() {
        updateHeight()
    }
}


