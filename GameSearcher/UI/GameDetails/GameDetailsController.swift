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
import AVFoundation
import AVKit
import Swiftools

class GameDetailsController: UIViewController {
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var collectionPageControl: PageIndicatorView!
    @IBOutlet weak var noScreensView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var platformsLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var expandArrow: UIButton!
    @IBOutlet weak var descriptionStackView: UIStackView!
    
    @IBOutlet weak var trailersCollectionView: UICollectionView!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    private let similarGamesDataSource = SimilarGamesDataSource()
    private let screenshotsDataSource  = ScreenshotsDataSource()
    private let trailersDataSource     = GameTrailersDataSource()
    
    private var screenshots: [String] = []
    
    var game: GameItem!
    
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
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log(game.id)
        getSimilarGames()
        setupGame(game)
        getTrailers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGradientNavBar()
    }
    
//MARK: - Setup
    
    private func getTrailers() {
        APIService.getGameTrailers(game.id) { error, trailers in
            if let trailers = trailers {
                trailers.forEach { Log($0.name)}
                self.trailersDataSource.set(self.trailersCollectionView, trailers)
            }
        }
    }
    
    private func getSimilarGames() {
        APIService.getSimilarGames(1, game.id) { error, games in
            if let games = games {
                self.similarGamesDataSource.set(collectionView: self.similarCollectionView, data: games, presentingVC: self)
            }
        }
    }
    
    private func setupGame(_ game: GameItem) {
        title = game.name
        releasedDateLabel.text = game.released
        genreLabel.text = game.genres.joined(separator: ", ")
        
        if let image = game.mainImage {
            screenshots.append(image)
            screenshotsCollectionView.reloadData()
        }
        
        fetchDetails {
            self.noScreensView.isHidden = !self.screenshots.isEmpty
            self.screenshotsDataSource.set(self.screenshotsCollectionView, self.screenshots, self.collectionPageControl)
        }
    }
    

    
//MARK: - Private methods
    
    private func fetchDetails(_ completion: @escaping () -> ()) {
        APIService.fetchGameDetails(gameId: game.id) { error, game in
            if let game = game {
                self.gameDescriptionLabel.text = game.gameInfo?.strip()
                self.platformsLabel.text = game.platforms.compactMap{ $0 }.joined(separator: ", ")
            }
        }
        
        APIService.getScreenshots(game.slug) { error, screenshots in
            if let screens = screenshots {
                screens.forEach {
                    self.screenshots.append($0.image)
                }
                self.screenshotsCollectionView.reloadData()
            }
            completion()
        }
    }
    
        
//MARK: - @IBActions
    
    @IBAction func didTapExpandDescription(_ sender: UITapGestureRecognizer) {
        isDescriptionVisible = !isDescriptionVisible
    }
    
    @IBAction func didPressSaveGameButton(_ sender: UIButton) {
        RealmService.shared.create(game)
    }
}

