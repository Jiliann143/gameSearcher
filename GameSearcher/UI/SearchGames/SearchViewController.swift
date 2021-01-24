//
//  ViewController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import SVPullToRefresh
import HelperKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var games = [GameItem]()
    
    private var finished = false
    private var page     = 2
    
    private var searchText: String {
        searchController.searchBar.searchTextField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavBar()
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        searchBar(searchController.searchBar, textDidChange: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func tableViewSetup() {
        tableView.registerCell(GameCell.self)
        addLazyLoading()
    }
    
    @IBAction func didPressMyGamesButton(_ sender: UIBarButtonItem) {
         let details = MyGamesViewController.instantiate("MyGames")
         push(details)
    }
    
    private func addLazyLoading() {
        tableView.addInfiniteScrolling {
            self.tableView.infiniteScrollingView.activityIndicatorViewStyle = .medium
            
            if self.finished {
                self.tableView.infiniteScrollingView.stopAnimating()
                return
            }
            
            APIService.fetchAllGames(page: self.page, searchText: self.searchText) { error, games in
                self.tableView.infiniteScrollingView.stopAnimating()
                
                guard let games = games else {
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
        
        APIService.fetchAllGames(page: 1, searchText: searchText) { error, games in
            guard let games = games else { return }
            self.games = games
            self.tableView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.cell(GameCell.self).setupGameInfo(games[indexPath.row])
    }
}


//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.openGameDetails(games[indexPath.row])
    }
}

