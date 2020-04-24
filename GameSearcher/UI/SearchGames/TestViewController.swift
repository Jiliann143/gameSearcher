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
    
    private var currentlyPlaying: UITableViewCell?
    
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
                self.tableView.reloadData()
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        autoPlayVideo()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            autoPlayVideo()
        }
    }
    
    private func autoPlayVideo() {
        guard let visibleCells = tableView.visibleCells as? [TestTableViewCell] else { return }
        visibleCells.forEach { $0.playerView.backgroundColor = .blue}
        let triggerPoint = CGPoint(x: tableView.bounds.midX, y: tableView.bounds.midY - 125)
        if let indexPath = tableView.indexPathForRow(at: triggerPoint) {
            guard let cell = tableView.cellForRow(at: indexPath) as? TestTableViewCell else { return }
            cell.playerView.backgroundColor = .yellow
            let cellsShouldStopPlaying = visibleCells.filter { $0 != cell }
            cellsShouldStopPlaying.forEach {$0.stopVideo() }
            cellsShouldStopPlaying.forEach { $0.playerView.backgroundColor = .systemPink }
            cell.playerView.playVideo()
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
