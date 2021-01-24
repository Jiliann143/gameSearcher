//
//  MainCoordinator.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/26/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openGameDetails(_ game: GameItem) {
        let vc = GameDetailsController.instantiate("GameDetails")
        vc.coordinator = self
        vc.game = game
        navigationController.pushViewController(vc, animated: true)
    }
    
}
