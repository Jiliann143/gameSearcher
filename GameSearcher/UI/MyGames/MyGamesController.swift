//
//  MyGamesController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/1/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import RealmSwift

class MyGamesViewController: UIViewController {
    
    private var dataSource: Results<GameItem>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = RealmService.shared.get(GameItem.self)
        
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        tableView.registerCell(GameCell.self)
    }
    
}


extension MyGamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.cell(GameCell.self).setupGameInfo(dataSource[indexPath.row])
    }
}



