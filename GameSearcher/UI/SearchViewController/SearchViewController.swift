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
        
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        tableViewSetup()
        setupSearchBar()
        searchBar(searchController.searchBar, textDidChange: "")
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
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
        tableView.registerCell(GameCell.self)
        tableView.separatorStyle = .none
        
        tableView.addInfiniteScrolling {
            self.tableView.infiniteScrollingView.activityIndicatorViewStyle = .medium
            
            if self.finished {
                self.tableView.infiniteScrollingView.stopAnimating()
                return
            }
            
            APIService.fetchAllGames(page: self.page, searchText: self.searchController.searchBar.searchTextField.text ?? "") { (games) in
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


//MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        finished = false
        page = 2
        tableView.infiniteScrollingView.stopAnimating()
        
        APIService.fetchAllGames(page: 1, searchText: searchText) { (games) in
               self.games = games
               self.tableView.reloadData()
           }
       }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(GameCell.self)
        let game = games[indexPath.row]
        cell.setupGameInfo(game)
        return cell
    }
}


//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           searchController.searchBar.resignFirstResponder()
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "GameDetails", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameDetailsController") as? GameDetailsController
        let game = games[indexPath.row]
        vc!.game = game
        push(vc!)
    }
}

