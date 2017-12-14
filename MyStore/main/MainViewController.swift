//
//  MainViewController.swift
//  MyAppStore
//
//  Created by School on 07/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    var context:  NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.register(UINib(nibName:"FormCell", bundle: nil), forCellReuseIdentifier: "form")
        
        self.mainTableView.register(UINib(nibName:"TabbedCell", bundle: nil), forCellReuseIdentifier: "tabbed")
        
       // CoreDataManager.insertStore()
    
        print("\n")
        CoreDataManager.fetchStores()?.forEach {
            print("\($0.name ?? " ")\n")
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "form", for: indexPath) as! FormCell
        }
        else if(indexPath.section == 1){
            cell = tableView.dequeueReusableCell(withIdentifier: "tabbed", for: indexPath) as! TabbedCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let frame = self.view.window?.frame {
            let height = frame.height
            let topHeight = height / 3
            
            if indexPath.section == 0 {
                return topHeight
            }else if indexPath.section == 1 {
                return height - topHeight
            }
        }
        
        return 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}
