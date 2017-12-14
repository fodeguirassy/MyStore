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
    
    lazy var storeListViewController : StoreListViewController = {
        let storeListViewController = StoreListViewController()
        storeListViewController.editStoreDelegate = self
        return storeListViewController
    }()
    
    lazy var mapViewController : MapViewController = {
        let mapViewController = MapViewController()
        self.onSumbitStoreDelegate = mapViewController
        return mapViewController
    }()
    
    
    public var visibleViewController: UIViewController {
        if self.mapViewController.view.window != nil{
            return self.mapViewController
        }
        return self.storeListViewController
    }
    
    var fetcher: GMSAutocompleteFetcher?
    var autocompleteTableView: UITableView!
    var predictions = [[String : String]]()
    
    var formCurrentStore = [String:Any]()
    
    weak var onSumbitStoreDelegate : DidAddStoreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(self.mapViewController, in: childContentview)
        
        self.storeNameTextField.placeholder = self.localizeString("app.vocabulary.form.name")
        self.storeDescTextField.placeholder = self.localizeString("app.vocabulary.form.description")
        self.storeAddressTextField.placeholder = self.localizeString("app.vocabulary.form.address")
        self.sumitStoreButton.setTitle(self.localizeString("app.vocabulary.form.button"), for: UIControlState.normal)
        
        
        self.storeAddressTextField.delegate = self
        self.storeNameTextField.delegate = self
        self.storeDescTextField.delegate = self
        
        
        self.storeAddressTextField.addTarget(self, action: #selector(searchForAddress), for: .editingChanged)
        
        fetcher = GMSAutocompleteFetcher(bounds: nil, filter: nil)
        fetcher!.delegate = self
        self.edgesForExtendedLayout = []
        
        self.autocompleteTableView = UITableView (frame: CGRect(self.storeAddressTextField.bounds.minX, self.sumitStoreButton.bounds.maxY,
                                                                self.view.bounds.width, self.storeAddressTextField.bounds.height * 4))
        self.autocompleteTableView.delegate = self
        self.autocompleteTableView.dataSource = self
        self.autocompleteTableView.isScrollEnabled = true
        self.autocompleteTableView.isHidden = true
        
        self.autocompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.autocompleteTableView)
        
    }
    
    func onEditStoreClick(_ storesListViewController: StoreListViewController, didselectStore store: [String : Any]) {
        
        print("\(store["name"] ?? "")")
        
        self.storeNameTextField.text = "\(store["name"] ?? "")"
        self.storeDescTextField.text = "\(store["description"] ?? "")"
        self.storeAddressTextField.text = "\(store["address"] ?? "")"
        
        
    }
    
    @objc func searchForAddress() {
        fetcher?.sourceTextHasChanged(self.storeAddressTextField.text)
    }
    
    
    @IBAction func touchSubmitStore(_ sender: Any) {
        
        
        guard
            let storeName = self.storeNameTextField.text,
            storeName.count > 0 ,
            let storeDescription = self.storeDescTextField.text,
            storeDescription.count > 0,
            let storeAddress = self.storeAddressTextField.text,
            storeAddress.count > 0
            else {
                
                let alert =  UIAlertController(title:
                    NSLocalizedString("app.vocabulary.form.error.title", comment: ""),
                                               message : NSLocalizedString("app.vocabulary.form.error.message", comment: ""),
                                               preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.form.error.action", comment: ""), style: .cancel))
                self.present(alert, animated: true)
                
                return
        }

        
        let placesClient = GMSPlacesClient()
        
        placesClient.lookUpPlaceID(self.formCurrentStore["placeId"] as! String, callback: {
            (place,error) -> Void in
            if error != nil {
                let alert =  UIAlertController(title:
                    NSLocalizedString("app.vocabulary.form.error.title", comment: ""),
                                               message : NSLocalizedString("app.vocabulary.form.error.message", comment: ""),
                                               preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.form.error.action", comment: ""), style: .cancel))
                self.present(alert, animated: true)
                return
            }
            
            guard let place = place else {
                let alert =  UIAlertController(title:
                    NSLocalizedString("app.vocabulary.geocode.empty.title", comment: ""),
                                               message : NSLocalizedString("app.vocabulary.geocode.empty.message", comment: ""),
                                               preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.geocode.empty.action", comment: ""), style: .cancel))
                self.present(alert, animated: true)
                
                return
            }
            
            self.formCurrentStore["name"] = storeName
            self.formCurrentStore["description"] = storeDescription
            self.formCurrentStore["longitude"] = place.coordinate.longitude
            self.formCurrentStore["latitude"] = place.coordinate.latitude
        
            
            CoreDataManager.insertStore(self.formCurrentStore)
            
            self.onSumbitStoreDelegate?.onStoreAdded()
            
        })
        
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

extension AppMainViewController: GMSAutocompleteFetcherDelegate {
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        
        if !predictions.isEmpty {
            
            self.autocompleteTableView.isHidden = false
            if(!self.predictions.isEmpty) {
                self.predictions.removeAll()
            }
            
            predictions.forEach {
                
                print("\($0.placeID ?? "")")
                
                self.predictions.append(["fullAddress" : $0.attributedFullText.string, "placeId": "\($0.placeID ?? "")"])
                self.autocompleteTableView.reloadData()
            }
        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print("\(error.localizedDescription)")
    }
    
}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}

extension AppMainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.predictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text =  self.predictions[indexPath.row]["fullAddress"]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10.0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.storeAddressTextField.text = self.predictions[indexPath.row]["fullAddress"]
        self.formCurrentStore["address"] = self.predictions[indexPath.row]["fullAddress"]
        self.formCurrentStore["placeId"] = self.predictions[indexPath.row]["placeId"]
        
        self.autocompleteTableView.isHidden = true
        
    }
    
    
}
extension AppMainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.autocompleteTableView.isHidden = true
    }
    
    
}

extension UIAlertController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}




