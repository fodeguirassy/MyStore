//
//  CoreDataManager.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var context: NSManagedObjectContext!
    
    class func insertStore(_ aStore:[String:Any]) {
    
        let store = Store(context: self.context)
    
        store.address = "\(aStore["address"] ?? "")"
        store.longitude = Double("\(aStore["longitude"] ?? "")")!
        store.latitude = Double("\(aStore["latitude"] ?? "")")!
        store.name = "\(aStore["name"] ?? "")"
        store.storeDesc = "\(aStore["description"] ?? "")"
    
        try? self.context.save()
    
    }
    
    class func fetchStores() -> [Store]? {
        let request : NSFetchRequest<Store> = Store.fetchRequest()
        guard let result = try? self.context.fetch(request) else {
            return nil
        }
        return result
    }
    
}
