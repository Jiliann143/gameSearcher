//
//  UIViewControllerTools.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/29/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import Swiftools


extension UIViewController {
    
    class func instantiate(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
}

public var topmostController: UIViewController {
    
    var topController = UIApplication.shared.keyWindow?.rootViewController;
    
    while topController?.presentedViewController != nil {
        topController = topController?.presentedViewController;
    }
    
    guard let controller = topController
        else { LogError(); return UIViewController() }
    
    return controller
}

public var keyWindow: UIView {
    
    guard let _window = UIApplication.shared.delegate?.window,
        let window = _window
        else { LogError(); return UIView() }
    
    return window
}

