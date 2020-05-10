//
//  ScreenshotsCollectionViewDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/20/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import Swiftools

class ScreenshotsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    private var screenshots: [String] = []
    private weak var collectionView: UICollectionView!
    private var pageControl: PageIndicatorView?
    
    func set(_ collection: UICollectionView, _ data: [String], _ pageControlView: PageIndicatorView) {
        collection.dataSource = self
        collection.delegate   = self
        collection.registerCell(ScreenshotCell.self)
        collectionView = collection
        pageControl = pageControlView
        screenshots = data
        Log(screenshots.count)
        pageControl?.numberOfPages = self.screenshots.count
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.cell(ScreenshotCell.self, for: indexPath).setup(screenshots[indexPath.item])
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
