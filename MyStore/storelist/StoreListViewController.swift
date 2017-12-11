//
//  StoreListViewController.swift
//  MyStore
//
//  Created by School on 10/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit

class StoreListViewController: UIViewController {

    @IBOutlet weak var storesListTableView: UITableView!
    
    var stores = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storesListTableView.delegate = self
        self.storesListTableView.dataSource = self
        //self.storesListTableView.allowsSelectionDuringEditing = false
        //self.storesListTableView.setEditing(true, animated: true)
     
        self.storesListTableView.allowsSelection = true
        
        
        if let rawStores = CoreDataManager.fetchStores() {
            rawStores.forEach {
                var currentStore = [String:Any]()
                
                currentStore["name"] = $0.name
                currentStore["latitude"] = $0.latitude
                currentStore["longitude"] = $0.longitude
                currentStore["description"] = $0.storeDesc
                currentStore["address"] = $0.address
                
                
                stores.append(currentStore)
            }
        }
        
        self.storesListTableView.register(UINib(nibName:"StoreCell", bundle: nil), forCellReuseIdentifier: "store")
        self.storesListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension StoreListViewController : UITableViewDelegate,
UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath)
        
        if let storeCell = cell as? StoreCell {
            
            storeCell.storeNameLabel.text = ("\(stores[indexPath.row]["name"] ?? " ")")
            storeCell.StoreDescriptionLabel.text = ("\(stores[indexPath.row]["description"] ?? " ")")
            storeCell.storeAddressLabel.text = ("\(stores[indexPath.row]["address"] ?? " ")")
            
        }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            print("\n\(stores[indexPath.row]["name"] ?? " ") is to be deleted\n")
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\n\(stores[indexPath.row]["name"] ?? " ") is selected\n")

    }
    
}
extension StoreListViewController {
    
    func hideKeyBoardWhenTapedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
    }
    
    @objc func dissmissKeyboard() {
        self.view.endEditing(true)
    }
    
}
