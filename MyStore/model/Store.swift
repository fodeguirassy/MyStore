//
//  Store.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension Store {
    public var annotion : MKAnnotation {
        let pointAnnotation = MKPointAnnotation()
        
        pointAnnotation.title = self.name
        pointAnnotation.coordinate.latitude = self.latitude
        pointAnnotation.coordinate.longitude = self.longitude
        pointAnnotation.subtitle = self.storeDesc
        
        return pointAnnotation
    }
    
}

