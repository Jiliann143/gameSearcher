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
    
    private var myGames: Results<GameItem>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = RealmService.shared.realm
        myGames = realm.objects(GameItem.self)
        
        tableViewSetup()
    }
    
    private func tableViewSetup() {
           tableView.registerCell(GameCell.self)
           tableView.estimatedRowHeight = 400
           tableView.rowHeight = UITableView.automaticDimension
           tableView.separatorStyle = .none
       }
    
}


extension MyGamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.cell(GameCell.self).setupGameInfo(myGames[indexPath.row])
    }
    
    
}

extension MyGamesViewController: UITableViewDelegate {
    
}


