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
    
    @IBOutlet weak var gameDescriptionTextView: UITextView!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    var game: GameItem!
    
    var imagesArray: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        screenshotsCollectionView.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
        setupGame(game)
        print(imagesArray)
    }
    
    func setupGame(_ game: GameItem) {
        title = game.name
        fetchDetails()
    }
    
    func fetchDetails() {
   
        APIService.fetchGameDetails(gameId: game.id) { (game) in
            self.gameDescriptionTextView.text = game.description
        }
        
        APIService.fetchGameScreenshots(gamePk: "") { (screenshots) in
            screenshots.forEach {
                guard let url = URL(string: $0.image) else {return}
               KingfisherManager.shared.retrieveImage(with: url) { result in
                    let image = try? result.get().image
                    if let image = image {
                        self.imagesArray.append(image)
                        self.screenshotsCollectionView.reloadData()
                    }
                }
            }
        }
    }
}


//MARK: - UICollectionView Stuff

extension GameDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCollectionViewCell", for: indexPath) as! ScreenshotCollectionViewCell
        let image = imagesArray[indexPath.item]
        cell.screenshot = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
