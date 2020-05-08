//
//  NavigationBarConfigurator.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/30/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import HelperKit

extension UIViewController {
    
    func setupDefaultNavBar() {
        if #available(iOS 13.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground()
            app.backgroundImage = nil
            app.shadowImage = nil
            app.titleTextAttributes = [.foregroundColor: UIColor.white]
            app.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            app.backgroundColor = .black
            navigationController?.navigationBar.scrollEdgeAppearance = app
            navigationController?.navigationBar.standardAppearance = app
            navigationController?.navigationBar.compactAppearance = app
        } else {
            
        }
    }
      
    
    func setupGradientNavBar() {
        let gradient = CAGradientLayer()
        guard let bounds = navigationController?.navigationBar.bounds else { return }
        var gradientBounds = bounds
        gradientBounds.size.height += Screen.statusBarHeight
        gradient.frame = gradientBounds
        
        let color = UIColor.black.withAlphaComponent(0.8).cgColor
        let clear = UIColor.black.withAlphaComponent(0.0).cgColor
        
        gradient.colors     = [color, clear]
        gradient.locations  = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint   = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            if #available(iOS 13.0, *) {
                let app = UINavigationBarAppearance()
                app.configureWithTransparentBackground()
                app.backgroundImage = image
                app.titleTextAttributes = [.foregroundColor: UIColor.white]
                app.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.standardAppearance = app
                self.navigationController?.navigationBar.scrollEdgeAppearance = app
                self.navigationController?.navigationBar.compactAppearance = app
            } else {
                navigationController?.navigationBar.shadowImage = UIImage()
                navigationController?.navigationBar.barTintColor = .clear
                navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            }
        }
    }
}

