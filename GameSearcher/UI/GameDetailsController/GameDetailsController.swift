//
//  GameDetailsController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/27/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class GameDetailsController: UIViewController {
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var collectionPageControl: PageIndicatorView!
    
    var game: GameItem!
    var screenshots: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        screenshotsCollectionView.registerCell(ScreenshotCell.self)
        setupGame(game)
        
    }
    
    func setupGame(_ game: GameItem) {
        title = game.name
        fetchDetails()
    }
    
    private func fetchDetails() {
        APIService.fetchGameDetails(gameId: game.id) { (game) in
            if let description = game.description {
                self.gameDescriptionLabel.text = description.strip()
            }
        }
        APIService.fetchGameScreenshots(gameName: game.slug) { (screenshots) in
            screenshots.forEach {
                self.screenshots.append($0.image)
            }
            self.collectionPageControl.numberOfPages = self.screenshots.count
            self.screenshotsCollectionView.reloadData()
        }
    }
}


//MARK: - UICollectionView Stuff

extension GameDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(ScreenshotCell.self, for: indexPath)
        let image = screenshots[indexPath.item]
        cell.screenshot = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if scrollView == screenshotsCollectionView {
               let x = scrollView.contentOffset.x
               let width = scrollView.bounds.size.width
               collectionPageControl.currentPage = Int(round(x/width))
           }
       }
    
}
