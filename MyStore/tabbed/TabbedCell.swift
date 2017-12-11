//
//  TabbedCell.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit

class TabbedCell: UITableViewCell {
    
    
    @IBOutlet weak var tabBar: UITabBar!
    
    lazy var mapviewController: MapViewController = {
        return MapViewController()
    }()
    
    lazy var storeListViewController: StoreListViewController = {
        return StoreListViewController()
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBar.delegate = self
        
        guard let tabBarItems = self.tabBar?.items
            else {
                //TODO TOAST
                return
        }
        
        
        let attributes: [NSAttributedStringKey: AnyObject] = [NSAttributedStringKey.font:UIFont(name:"Helvetica", size:22.0)!]
        for tabBarItem in tabBarItems {
            tabBarItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
        }
        
        self.tabBar.insertSubview(self.mapviewController.view, at: 0)
        self.tabBar.insertSubview(self.storeListViewController.view, at: 1)
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TabbedCell : UITabBarDelegate, UITabBarControllerDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0 {
            self.tabBar.insertSubview(self.mapviewController.view, at: 0)
        }else {
            self.tabBar.insertSubview(self.storeListViewController.view, at: 1)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        print("\(viewController.nibName ?? " ")")
        
    }
    
    
}
