//
//  MyGamesController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/1/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import RealmSwift
import Swiftools

enum PresentationType {
    case all
    case byYear
}

class MyGamesViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var games: Results<GameItem> {
        RealmService.shared.objects(GameItem.self)
    }
    private var groupedGames = [[GameItem]]()
    
    private var type: PresentationType = .all {
        didSet {
            layoutCollection(for: type)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembleGroupedGames()
        collectionViewSetup()
    }
    
    private func layoutCollection(for type: PresentationType) {
        collectionView.reloadData()

        switch type {
        case .all:
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createAllGamesLayout(), animated: true)
        case .byYear:
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createSortedLayout(), animated: true)
        }
    }
    
    private func collectionViewSetup() {
        collectionView.collectionViewLayout = MyGamesLayoutManager.createAllGamesLayout()
        collectionView.registerCell(SimilarGamesCell.self)
        collectionView.registerHeader(HeaderView.self)
    }
    
    private func assembleGroupedGames() {
        let groupedUsers = Dictionary(grouping: games) { $0.releaseYear }
        let sortedKeys = groupedUsers.keys.sorted { $0 > $1 }
        sortedKeys.forEach { (key) in
            if let values = groupedUsers[key] {
                groupedGames.append(values)
            }
        }
    }
    
    @IBAction func didPressSwitchLayout(_ sender: UIBarButtonItem) {
        if type == .all { type = .byYear }
        else { type = .all }
    }
}


extension MyGamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .all:
            print(games[indexPath.row].name)
            return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(games[indexPath.row])
        case .byYear:
            return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(groupedGames[indexPath.section][indexPath.row])
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        type == .all ? games.count : groupedGames[section].count
    }
    
}

extension MyGamesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LogInfo(games[indexPath.item].gameInfo)
        LogInfo(games[indexPath.item].releaseYear)
    }
}

extension MyGamesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if type == .all { return UICollectionReusableView() }
        let firstItemInSectionYear = groupedGames[indexPath.section].first!.releaseYear
        return collectionView.header(HeaderView.self, for: indexPath).setup(String(firstItemInSectionYear))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        type == .all ? 1 : groupedGames.count
    }
}




