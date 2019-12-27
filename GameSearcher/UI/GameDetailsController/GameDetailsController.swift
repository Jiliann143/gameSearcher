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
    
    @IBOutlet weak var gameCoverImageView: UIImageView!
    @IBOutlet weak var gameDescriptionTextView: UITextView!

    var game: GameItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame(game)
        setupNavBar()
    }
    
    func setupGame(_ game: GameItem) {
        title = game.name
        guard let url = URL(string: game.background_image) else {return}
        gameCoverImageView.kf.setImage(with: url)
        fetchDetails()
    }
    
    func fetchDetails() {
        APIService.fetchGameDetails(gameId: game.id) { (game) in
            self.gameDescriptionTextView.text = game.description
        }
      }

    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

     }
}
