//
//  AppMainViewController.swift
//  MyStore
//
//  Created by School on 11/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit
import GooglePlaces

class AppMainViewController: UIViewController, EditStoreDelegate {
   
    @IBOutlet weak var storeNameTextField: UITextField!
    
    @IBOutlet weak var storeDescTextField: UITextField!
    
    @IBOutlet weak var storeAddressTextField: UITextField!
    
    @IBOutlet weak var sumitStoreButton: UIButton!
    
    @IBOutlet weak var childContentview: UIView!
    
    lazy var gmsAutocompleteViewController: GMSAutocompleteViewController = {
        let gmsAutocompleteViewController = GMSAutocompleteViewController()
        gmsAutocompleteViewController.delegate = self
        return gmsAutocompleteViewController
    }()
    
    

    lazy var storeListViewController : StoreListViewController = {
        let storeListViewController = StoreListViewController()
        storeListViewController.editStoreDelegate = self
       return storeListViewController
    }()
    
    lazy var mapViewController : MapViewController = {
        let mapViewController = MapViewController()
        return mapViewController
    }()
    
    
    public var visibleViewController: UIViewController {
        if self.mapViewController.view.window != nil
        {
            return self.mapViewController
        }
        return self.storeListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(self.mapViewController, in: childContentview)
        
        self.storeNameTextField.placeholder = self.localizeString("appstore.form.name")
        self.storeDescTextField.placeholder = self.localizeString("appstore.form.description")
        self.storeAddressTextField.placeholder = self.localizeString("appstore.form.address")
        
        self.sumitStoreButton.setTitle(self.localizeString("appstore.form.button"), for: UIControlState.normal)
        
        self.storeAddressTextField.addTarget(self, action: #selector(searchForAddress), for: .allEditingEvents)
    
    }
    
    func onEditStoreClick(_ storesListViewController: StoreListViewController, didselectStore store: [String : Any]) {
        
        print("\(store["name"] ?? "")")
        
        self.storeNameTextField.text = "\(store["name"] ?? "")"
        self.storeDescTextField.text = "\(store["description"] ?? "")"
        self.storeAddressTextField.text = "\(store["address"] ?? "")"

    }
    
    @objc func searchForAddress() {
        
       // self.present(gmsAutocompleteViewController, animated: true, completion: nil)
        self.navigationController?.present(gmsAutocompleteViewController, animated: true, completion: nil)
    }
    
    @IBAction func touchSubmitStore(_ sender: Any) {
        
    }
    
    @IBAction func touchSwitchSubviews(_ sender: Any) {
        let visible = self.visibleViewController
        self.removeChildViewController(visible)
        if(visible == self.mapViewController) {
            self.addChildViewController(self.storeListViewController, in: self.childContentview)
        }else {
            self.addChildViewController(self.mapViewController, in: self.childContentview)
        }
    }
    
    
    fileprivate func localizeString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AppMainViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("place name\(place.formattedAddress ?? "")")
        print("place attributions \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Cancelled")
    }

    
}










