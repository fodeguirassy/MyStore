//
//  SwitchChildViews.swift
//  MyStore
//
//  Created by School on 10/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addChildViewController(_ childViewController: UIViewController, in subview: UIView){
        guard let view = childViewController.view else {
            return
        }
        
        view.frame = subview.bounds
        view.autoresizingMask = UIViewAutoresizing(rawValue: 0b111111)
        
        subview.addSubview(view)
        self.addChildViewController(childViewController)
    }
    
    func removeChildViewController(_ childController: UIViewController){
        childController.removeFromParentViewController()
        childController.view.removeFromSuperview()
    }
    
}

