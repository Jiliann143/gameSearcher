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
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var topRatingLabel: UILabel!
    @IBOutlet weak var noScreensView: UIImageView!
    
    @IBOutlet weak var expandArrow: UIButton!
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    var isDescriptionVisible: Bool = false {
        didSet {
            if isDescriptionVisible == false {
                expandArrow.rotateView(360)
                gameDescriptionLabel.hideAnimated()
            } else {
                expandArrow.rotateView(180)
                gameDescriptionLabel.showAnimated()
            }
        }
    }
    
    var game: GameItem!
    var screenshots: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDescriptionLabel.isHidden = true
        screenshotsCollectionView.registerCell(ScreenshotCell.self)
        setupGame(game)
    }
    
    func setupGame(_ game: GameItem) {
        title = game.name
        fetchDetails {
            self.noScreensView.isHidden = !self.screenshots.isEmpty
        }
    }
    
    private func fetchDetails(_ completion: @escaping () -> ()) {
        APIService.fetchGameDetails(gameId: game.id) { game in
            if let game = game {
                self.gameDescriptionLabel.text = game.description?.strip()
            }
        }
        
        APIService.getScreenshots(game.slug) { screenshots in
            if let screens = screenshots {
                screens.forEach {
                    self.screenshots.append($0.image)
                }
                self.collectionPageControl.numberOfPages = self.screenshots.count
                self.screenshotsCollectionView.reloadData()
            }
            completion()
        }
    }
    
    @IBAction func didTapExpandDescription(_ sender: UITapGestureRecognizer) {
        isDescriptionVisible = !isDescriptionVisible
    }
}


//MARK: - UICollectionView Stuff

extension GameDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(ScreenshotCell.self, for: indexPath)
        cell.screenshot = screenshots[indexPath.item]
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
