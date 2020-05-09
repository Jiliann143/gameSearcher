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

class MyGamesViewController: UIViewController {
    
    private var games: Results<GameItem>!
    private var groupedGames = [[GameItem]]()
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        games = RealmService.shared.objects(GameItem.self)
        assembleGroupedGames()
        collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
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
}


extension MyGamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(groupedGames[indexPath.section][indexPath.row])
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupedGames[section].count
    }
    
}

extension MyGamesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LogInfo(games[indexPath.item].gameInfo)
        LogInfo(games[indexPath.item].releaseYear)
    }
}

extension MyGamesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let firstItemInSectionYear = groupedGames[indexPath.section].first!.releaseYear
        return collectionView.header(HeaderView.self, for: indexPath).setup(String(firstItemInSectionYear))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10 - collectionView.contentInset.left
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}




