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
    
    
    class func insertStore() {
        let store = Store(context: self.context)
        
        store.address = "6 rue de l'ancienne militaire, 91120, Palaiseau"
        store.longitude = 2.247620
        store.latitude = 48.724894
        store.name = "Apple Store La Défense"
        store.storeDesc = "The third best App Store in Paris"
        
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
