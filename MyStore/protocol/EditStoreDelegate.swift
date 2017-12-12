//
//  EditStoreDelegate.swift
//  MyStore
//
//  Created by School on 11/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import Foundation

public protocol EditStoreDelegate: class {
    
    func onEditStoreClick(_ storesListViewController: StoreListViewController,
    didselectStore store:[String: Any])

}
