//
//  TestViewController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/21/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import Swiftools

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Trailer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(TestTableViewCell.self)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIService.getGameTrailers(3498) { error, trailers in
            if let trailers = trailers {
                self.data = trailers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.cell(TestTableViewCell.self).setup(data[indexPath.row])
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? TestTableViewCell else { return }
        videoCell.playerView.player?.pause()
        videoCell.playerView.player = nil
    }
}
