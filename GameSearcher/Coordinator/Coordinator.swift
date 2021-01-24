//
//  Coordinator.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/26/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator]  { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
