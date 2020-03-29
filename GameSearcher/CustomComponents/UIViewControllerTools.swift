//
//  UIViewControllerTools.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/29/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func defaultTabBar() {
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    
    func gradientTabBar() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
        let gradient = CAGradientLayer()
        var bounds = navigationController?.navigationBar.bounds
        bounds?.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        gradient.frame = bounds!
        let color  = UIColor.black.withAlphaComponent(0.8).cgColor
        let color2 = UIColor.black.withAlphaComponent(0.6).cgColor
        let color3 = UIColor.black.withAlphaComponent(0.3).cgColor
        let color4 = UIColor.black.withAlphaComponent(0.1).cgColor
        let clear  = UIColor.black.withAlphaComponent(0.0).cgColor
        
        gradient.colors = [color, color2, color3, color4, clear]
        gradient.locations = [0.0, 0.4, 0.6, 0.8, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
    }
}

func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
     var gradientImage:UIImage?
     UIGraphicsBeginImageContext(gradientLayer.frame.size)
     if let context = UIGraphicsGetCurrentContext() {
         gradientLayer.render(in: context)
         gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
     }
     UIGraphicsEndImageContext()
     return gradientImage
 }
