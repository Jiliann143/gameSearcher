//
//  GameTrailersDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class GameTrailersDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var trailers: [Trailer] = []
    private weak var collectionView: UICollectionView!
      
      func set(_ collectionView: UICollectionView, _ data: [Trailer]) {
          collectionView.dataSource = self
          collectionView.delegate   = self
          collectionView.registerCell(TrailerCell.self)
          self.collectionView = collectionView
          self.trailers = data
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.cell(TrailerCell.self, for: indexPath).setup(trailers[indexPath.item])
    }
    
    //MARK:- UICollectionViewDelegate + FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
