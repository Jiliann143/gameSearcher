//
//  SortedGamesCollectionViewLayout.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/10/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class MyGamesLayoutManager: NSObject {
    
    static func createSortedLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(0.4),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: "header",
                                                                 alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems  = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    static func createAllGamesLayout() -> UICollectionViewCompositionalLayout {
        let largeItemSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(0.6),
                                                   heightDimension: .fractionalHeight(1.0))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let sideItemSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(1.0))
        let sideItem = NSCollectionLayoutItem(layoutSize: sideItemSize)
        sideItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 4)

        
        let sideGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                                                          widthDimension: .fractionalWidth(0.4),
                                                          heightDimension: .fractionalHeight(1.0)),
                                                         subitem: sideItem, count: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                        widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .fractionalWidth(0.7)),
                                                       subitems: [largeItem, sideGroup])
        
        let douetItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                widthDimension:  .fractionalWidth(0.5),
                                                heightDimension: .fractionalWidth(0.5)))

        douetItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let douetGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                                                               widthDimension: .fractionalWidth(1.0),
                                                               heightDimension: .fractionalWidth(0.5)),
                                                              subitems: [douetItem, douetItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                                                            widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)),
                                                           subitems: [group, douetGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    
}
