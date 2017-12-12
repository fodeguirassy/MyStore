//
//  StoreListViewController.swift
//  MyStore
//
//  Created by School on 10/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//
/*
 let alert =  UIAlertController(title:
 NSLocalizedString("app.vocabulary.error.title", comment: ""),
 message : NSLocalizedString("app.vocabulary.error.error_message", comment: ""),
 preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.error.close", comment: ""), style: .cancel))
 
 self.present(alert, animated: true)
 
 return
 */


import UIKit

public class StoreListViewController: UIViewController {

    @IBOutlet weak var storesListTableView: UITableView!
    
    var stores : [[String: Any]]!
    public weak var editStoreDelegate : EditStoreDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.storesListTableView.delegate = self
        self.storesListTableView.dataSource = self
        
        self.storesListTableView.allowsSelection = true
        
        
        
        if let rawStores = CoreDataManager.fetchStores() {
            stores = [[String:Any]]()
            
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

    }
    
   public  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension StoreListViewController : UITableViewDelegate,
UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  stores.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath)
        
        if let storeCell = cell as? StoreCell {
            
                storeCell.storeNameLabel.text = ("\(stores[indexPath.row]["name"] ?? " ")")
                storeCell.StoreDescriptionLabel.text = ("\(stores[indexPath.row]["description"] ?? " ")")
                storeCell.storeAddressLabel.text = ("\(stores[indexPath.row]["address"] ?? " ")")
            
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction (style: .destructive, title : self.localizeString("appstore.row.action.delete")){
            (action, indexPath) in
            
        
        }
        
        let edit =  UITableViewRowAction (style: .normal, title : self.localizeString("appstore.row.action.edit")){
            (action, indexPath) in
            
            print("Edit Button pressed at \t \(self.stores[indexPath.row]["name"] ?? " ")")
            
            self.editStoreDelegate?.onEditStoreClick(self, didselectStore: self.stores[indexPath.row] as! [String : Any])
            
        }
        
        edit.backgroundColor = UIColor.brown
        
        return [delete, edit]
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            print("\n\(stores[indexPath.row]["name"] ?? " ") is to be deleted\n")
            
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\n\(stores[indexPath.row]["name"] ?? " ") is selected\n")

    }
    
    fileprivate func localizeString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
}
