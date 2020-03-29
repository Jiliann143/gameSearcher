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
import RealmSwift

class GameDetailsController: UIViewController {
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var collectionPageControl: PageIndicatorView!
    @IBOutlet weak var noScreensView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var platformsLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet weak var expandArrow: UIButton!
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    
    var game: GameItem!
    var screenshots: [String] = []
    
    var isDescriptionVisible: Bool = false {
        didSet {
            if isDescriptionVisible {
                expandArrow.rotateView(360)
                gameDescriptionLabel.hideAnimated()
            } else {
                expandArrow.rotateView(180)
                gameDescriptionLabel.showAnimated()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDescriptionLabel.isHidden = true
        screenshotsCollectionView.registerCell(ScreenshotCell.self)
        setupGame(game)
    }
    
//MARK: - Setup
    
    private func setupGame(_ game: GameItem) {
        title = game.name
        releasedDateLabel.text = game.released
        genreLabel.text = game.genres.compactMap{ $0.name }.joined(separator: ", ")
        fetchDetails {
            self.noScreensView.isHidden = !self.screenshots.isEmpty
        }
    }

    
//MARK: - Private methods
    
    private func fetchDetails(_ completion: @escaping () -> ()) {
        APIService.fetchGameDetails(gameId: game.id) { game in
            if let game = game {
                self.gameDescriptionLabel.text = game.game_description?.strip()
       //         self.developerLabel.text = game.developers.compactMap{ $0.devName }.joined(separator: ", ")
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
    
    @IBAction func didPressSaveGameButton(_ sender: UIButton) {
        RealmService.shared.create(game)
    }
}


//MARK: - UICollectionViewDataSource

extension GameDetailsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(ScreenshotCell.self, for: indexPath)
        cell.screenshot = screenshots[indexPath.item]
        return cell
    }
    
}
    
    //MARK: - UICollectionViewDelegate

extension GameDetailsController: UICollectionViewDelegate {
    
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
