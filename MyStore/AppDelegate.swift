//
//  AppDelegate.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

//ID: mystore-188809
//Numero: 530635369380
//key : AIzaSyDD-D6xSFadP-NQ76AVkZMoMo6hfCUygGo

import UIKit
import CoreData
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context:  NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.context = self.loadCoreDataContext()
        CoreDataManager.context = self.context
        
        
        GMSPlacesClient.provideAPIKey("AIzaSyDD-D6xSFadP-NQ76AVkZMoMo6hfCUygGo")
        
        let mainViewController = AppMainViewController()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController =  PortraitNavigationController(rootViewController:  mainViewController)
        
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }
}

extension AppDelegate {
    
    func  loadCoreDataContext() -> NSManagedObjectContext?  {
        guard
            let schemaURL = Bundle.main.url(forResource: "MyStore", withExtension:"momd"),
            let model = NSManagedObjectModel(contentsOf: schemaURL)
            else {
                return nil
        }
        
        let store = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                return nil
        }
        let storageUrl = documentDirectory.appendingPathComponent("AppStores.sqlite")
        
        print(storageUrl)
        
        _ = try? store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageUrl, options: nil)
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = store
        return context
    }
    
    
    
}

