//
//  ScreenshotsCollectionViewDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class ScreenshotsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    private var screenshots: [String] = []
    private weak var collectionView: UICollectionView!
    private var pageControl: PageIndicatorView?
    
    func set(_ collectionView: UICollectionView, _ data: [String], _ pageControl: PageIndicatorView) {
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.registerCell(ScreenshotCell.self)
        self.collectionView = collectionView
        self.pageControl = pageControl
        self.screenshots = data
        self.pageControl?.numberOfPages = self.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(ScreenshotCell.self, for: indexPath)
        cell.screenshot = screenshots[indexPath.item]
        return cell
    }
      
//MARK:- UICollectionViewDelegate + FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let x = scrollView.contentOffset.x
            let width = scrollView.bounds.size.width
            pageControl?.currentPage = Int(round(x/width))
        }
    }
}
