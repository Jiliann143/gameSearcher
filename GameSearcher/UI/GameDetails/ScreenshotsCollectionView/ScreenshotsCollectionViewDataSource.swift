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
    
    private weak var collectionView: UICollectionView!
  
    var screenshots: [String] = [] {
        didSet {
            placeholder.isHidden = !screenshots.isEmpty
            pageControl?.numberOfPages = screenshots.count
        }
    }
        
    private var pageControl: PageIndicatorView?
    
    private lazy var placeholder: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "testimage")
        imageView.contentMode = .scaleAspectFill
        imageView.frame = collectionView.bounds
        return imageView
    }()
    
    func set(_ collection: UICollectionView, _ pageControlView: PageIndicatorView?) {
        collection.dataSource = self
        collection.delegate   = self
        collection.registerCell(ScreenshotCell.self)
        collectionView = collection
        pageControl = pageControlView
        collectionView.backgroundView = placeholder
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.cell(ScreenshotCell.self, for: indexPath).setup(screenshots[indexPath.item])
    }
    
      
//MARK:- UICollectionViewDelegate + FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let x = scrollView.contentOffset.x
            let width = scrollView.bounds.size.width
            pageControl?.currentPage = Int(round(x/width))
        }
    }
}

