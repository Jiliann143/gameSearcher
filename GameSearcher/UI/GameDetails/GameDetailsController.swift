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
import HelperKit
import Swiftools

class GameDetailsController: UIViewController {
    
    @IBOutlet weak var collectionPageControl: PageIndicatorView!
    @IBOutlet weak var noScreensView: UIImageView!
    @IBOutlet weak var trailersCollectionView: UICollectionView!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var gameInfoTableView: InfoTableView!
    
    private let similarGamesDataSource = SimilarGamesDataSource()
    private let screenshotsDataSource  = ScreenshotsDataSource()
    private let trailersDataSource     = GameTrailersDataSource()
    
    @IBOutlet weak var addToPlayedButton: TwoStateButton!
    @IBOutlet weak var addToListButton: TwoStateButton!
    
    private var screenshots: [String] = []
    private var storedGame: GameItem? {
        RealmService.shared.object(GameItem.self, key: game.id)
    }
    
    var game: GameItem! {
        didSet {
            if let game = RealmService.shared.object(GameItem.self, key: game.id) {
                self.game = game
            }
        }
    }
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log(game.id)
        setupButtonsState()
        getSimilarGames()
        setupGame(game)
        gameInfoTableView.setup(game)
     //   getTrailers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGradientNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handleSaveButtonsState()
    }
    
//MARK: - Setup
    
    private func getTrailers() {
        APIService.getGameTrailers(game.id) { error, trailers in
            if let trailers = trailers {
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
        if let image = game.mainImage {
            screenshots.append(image)
            screenshotsCollectionView.reloadData()
        }
        fetchDetails {
            self.noScreensView.isHidden = !self.screenshots.isEmpty
            self.screenshotsDataSource.set(self.screenshotsCollectionView, self.screenshots, self.collectionPageControl)
        }
    }
    
    private func setupButtonsState() {
        guard let game = storedGame else { return }
        addToListButton.isActive = game.isFavourite
        addToPlayedButton.isActive = game.played
    }
    
    private func handleSaveButtonsState() {
        if let game = storedGame {
            (!addToListButton.isActive && !addToPlayedButton.isActive) ? RealmService.shared.delete(game) : RealmService.shared.append(game)
        }
    }
    
//MARK: - Private methods
    
    private func fetchDetails(_ completion: @escaping () -> ()) {
        APIService.fetchGameDetails(gameId: game.id) { error, game in
            if let game = game {
                self.game = game
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
    
    @IBAction func didPressSaveGameButton(_ sender: TwoStateButton) {
        sender.togle()
        RealmService.shared.commitWriting {
            game.isFavourite = sender.isActive
            RealmService.shared.append(game)
        }
    }
    
    @IBAction func didPressAddToPlayedButton(_ sender: TwoStateButton) {
        sender.togle()
        RealmService.shared.commitWriting {
            game.played = sender.isActive
            RealmService.shared.append(game)
        }
    }
}


