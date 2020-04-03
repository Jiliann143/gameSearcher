//
//  SimilarGamesCollectionViewDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class SimilarGamesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var data = [GameItem]()
    
    private weak var collectionView: UICollectionView!
    
    func set(collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.registerCell(SimilarGamesCell.self)
        self.collectionView = collectionView
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.cell(SimilarGamesCell.self, for: indexPath)
    }
    
}
