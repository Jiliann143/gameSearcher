//
//  Utils.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/27/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher

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
        
        let dismissCompletion = { () -> Void in // dismiss all modal view controllers
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


extension UITableView {
    
    func cell<T>(_ type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
    
    func registerCell<T>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: type))
    }
}

extension UICollectionView {
    
    func registerCell<T>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: type))
    }
    
    func cell<T>(_ type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}

extension UIViewController {
    
    class func instantiate(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }

    
    func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func present(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func htmlAttributed() -> NSAttributedString? {
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        return NSAttributedString()
    }
    
    func strip() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

public extension UIView {
    
    func showAnimated() {
           UIView.animate(withDuration: 0.3) {
               self.isHidden = false
           }
       }
    
    func hideAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
        }
    }
    
    func rotateView(_ angle: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform(rotationAngle: angle * .pi / 180)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { clipsToBounds = true; layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { return UIColor.clear }
    }
    
    var viewController: UIViewController? {
        var controller: UIResponder? = self.next
        while controller != nil {
            if let controller = controller as? UIViewController { return controller }
            controller = controller?.next
        }
        return nil
    }
    
    func flip() {
        layer.transform = CATransform3DConcat(layer.transform,
                                              CATransform3DMakeRotation(CGFloat.pi, 1.0, 0.0, 0.0))
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addTransparentBlur(style: UIBlurEffect.Style = .light) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            insertSubview(blurEffectView, at: 0)
        }
        else {
            backgroundColor = UIColor.clear
        }
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
