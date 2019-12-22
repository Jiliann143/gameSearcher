//
//  ViewController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import SVPullToRefresh

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var games = [GameItem]()
    
    private var finished = false
    private var page     = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        tableViewSetup()
        setupSearchBar()
        searchBar(searchController.searchBar, textDidChange: "")
       
    }
    
    private func setupSearchBar() {
           self.definesPresentationContext = true
           navigationItem.searchController = searchController
           navigationItem.hidesSearchBarWhenScrolling = false
           searchController.searchBar.delegate = self
           searchController.obscuresBackgroundDuringPresentation = false
       }
    
    private func tableViewSetup() {
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "GameCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        tableView.separatorStyle = .none
        
        tableView.addInfiniteScrolling {
            self.tableView.infiniteScrollingView.activityIndicatorViewStyle = .medium
            
            if self.finished {
                self.tableView.infiniteScrollingView.stopAnimating()
                return
            }
            
            APIService.shared.fetchGames(page: self.page, searchText: self.searchController.searchBar.searchTextField.text ?? "") { (games) in
                self.tableView.infiniteScrollingView.stopAnimating()

                if games.count == 0 {
                    self.finished = true
                    return
                }
                
                self.games += games
                self.page += 1
                self.tableView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        finished = false
        page = 2
        tableView.infiniteScrollingView.stopAnimating()
        
        APIService.shared.fetchGames(page: 1, searchText: searchText) { (games) in
               self.games = games
               self.tableView.reloadData()
           }
       }
}


extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = games[indexPath.row]
        cell.setupGameInfo(game)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           searchController.searchBar.resignFirstResponder()
       }
}

