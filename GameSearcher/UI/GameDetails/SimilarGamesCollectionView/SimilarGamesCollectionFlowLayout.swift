//
//  SimilarGamesCollectionFlowLayout.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

extension SimilarGamesDataSource: UICollectionViewDelegateFlowLayout {
    
    static private let interitemPadding: CGFloat = 10
    static private let sidePadding: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - SimilarGamesDataSource.sidePadding - SimilarGamesDataSource.interitemPadding / 2
        let height = collectionView.frame.height - SimilarGamesDataSource.sidePadding
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SimilarGamesDataSource.interitemPadding
    }
    
}
