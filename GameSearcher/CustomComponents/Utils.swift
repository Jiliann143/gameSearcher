//
//  Utils.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/27/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

extension UIView {
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}

extension UIWindow {
    func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool = true, completion: (() -> ())? = nil) {
        let snapshotImageView = UIImageView(image: self.snapshot())
        self.addSubview(snapshotImageView)
        
        let dismissCompletion = { () -> Void in
            self.rootViewController = replacementController
            self.bringSubviewToFront(snapshotImageView)
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                }, completion: { (success) -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            }
            else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        if self.rootViewController!.presentedViewController != nil {
            self.rootViewController!.dismiss(animated: false, completion: dismissCompletion)
        }
        else {
            dismissCompletion()
        }
    }
}

var window: UIWindow {
    (UIApplication.shared.delegate as! AppDelegate).window!
}

func setRootController(_ controller: UIViewController) {
    window.replaceRootViewControllerWith(controller)
}

//done
extension String {
    
    func strip() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


extension UIImageView {
    
    func loadImage(_ urlString: String?) {
        guard let string = urlString else { return }
        guard let url = URL(string: string) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
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

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UITableView {
    
    func updateHeight() {
           DispatchQueue.main.async {
               self.beginUpdates()
               self.endUpdates()
           }
       }
}


