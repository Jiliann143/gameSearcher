//
//  SimilarGamesCollectionViewDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class SimilarGamesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    private var data = [GameItem]()
    private var presentingVC: UIViewController!
    
    private weak var collectionView: UICollectionView!
    
    func set(collectionView: UICollectionView, data: [GameItem], presentingVC: UIViewController) {
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.registerCell(SimilarGamesCell.self)
        self.collectionView = collectionView
        self.presentingVC = presentingVC
        self.data = data
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(data[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = GameDetailsController.instantiate("GameDetails")
        details.game = data[indexPath.item]
        presentingVC.push(details)
    }
}
