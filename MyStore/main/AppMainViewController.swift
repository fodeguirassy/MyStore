//
//  AppMainViewController.swift
//  MyStore
//
//  Created by School on 11/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit

class AppMainViewController: UIViewController {
    
   
    @IBOutlet weak var storeNameTextField: UITextField!
    
    @IBOutlet weak var storeDescTextField: UITextField!
    
    @IBOutlet weak var storeAddressTextField: UITextField!
    
    @IBOutlet weak var sumitStoreButton: UIButton!
    
    @IBOutlet weak var childContentview: UIView!
    
    
    @IBAction func touchSwitchSubviews(_ sender: Any) {
        
        
    
    }
    
    
    lazy var storeListViewController : StoreListViewController = {
       return StoreListViewController()
    }()
    
    lazy var mapViewController : MapViewController = {
        return MapViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(self.mapViewController, in: childContentview)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
