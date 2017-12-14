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
import GoogleMaps

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
        
        let camera = MKMapCamera(lookingAtCenter: self.mapView.userLocation.coordinate,
                                 fromEyeCoordinate: self.mapView.userLocation.coordinate,
                                 eyeAltitude: CLLocationDistance(100000))
        self.mapView.setCamera(camera, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadStoresOnMap() {
        if !self.mapView.annotations.isEmpty {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        guard let stores = CoreDataManager.fetchStores() else {
            
            let alert =  UIAlertController(title:
                NSLocalizedString("app.vocabulary.database.failed.title", comment: ""),
                                           message : NSLocalizedString("app.vocabulary.database.fetch.failed.message", comment: ""),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.database.failed.action", comment: ""), style: .cancel))
            self.present(alert, animated: true)
            
            return
        }
        
        if stores.isEmpty {
            let alert =  UIAlertController(title:
                NSLocalizedString("app.vocabulary.database.empty.title", comment: ""),
                                           message : NSLocalizedString("app.vocabulary.database.empty.message", comment: ""),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("app.vocabulary.database.empty.action", comment: ""), style: .cancel))
            self.present(alert, animated: true)
        }
        
        self.mapView.addAnnotations(stores.map{$0.annotion})
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       self.loadStoresOnMap()
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

extension MapViewController: DidAddStoreDelegate {
    
    func onStoreAdded() {
        self.loadStoresOnMap()
    }
}
