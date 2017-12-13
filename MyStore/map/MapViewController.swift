//
//  MapViewController.swift
//  MyStore
//
//  Created by School on 09/12/2017.
//  Copyright © 2017 Fodé Guirassy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        if(CLLocationManager.locationServicesEnabled()) {
            let manager = CLLocationManager()
            manager.requestWhenInUseAuthorization()
            self.locationManager = manager
        }
        
        self.locationManager.startUpdatingLocation()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let stores = CoreDataManager.fetchStores() else {
            
             let alert =  UIAlertController(title:
             NSLocalizedString("app.vocabulary.error.title", comment: ""),
             message : NSLocalizedString("app.vocabulary.error.error_message", comment: ""),
             preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.error.close", comment: ""), style: .cancel))
             
             self.present(alert, animated: true)
 
            
            
            
            return
        }
        self.mapView.addAnnotations(stores.map{$0.annotion})
    }
    

}

extension MapViewController: MKMapViewDelegate {
    
    public static let appleStoreIdentifier = "ASI"
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation){
            return nil
        }
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewController.appleStoreIdentifier)
        if let reused = view {
            reused.annotation = annotation
            return reused
        }
        
        let pin = MKPinAnnotationView(annotation : annotation, reuseIdentifier: MapViewController.appleStoreIdentifier )
        pin.canShowCallout = true
        pin.pinTintColor = UIColor.blue
        return pin
        
    }
    
}
