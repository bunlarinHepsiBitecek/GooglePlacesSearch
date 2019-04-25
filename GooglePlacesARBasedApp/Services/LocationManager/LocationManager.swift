//
//  LocationManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/18/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let shared = LocationManager()
    
    var locationManager: CLLocationManager!
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = CONSTANT.MAP_KIT_CONSTANT.DISTANCE_FILTER_10
        locationManager.allowsBackgroundLocationUpdates = true // Enable background location updates
        locationManager.pausesLocationUpdatesAutomatically = true // Enable automatic pausing
    }
    
    func startUpdateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
        
    }
    
    func stopUpdateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            self.locationManager.stopUpdatingLocation()
            return
        }
        // Notify the user of any errors.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations invoked")
        print("Remzi didUpdateLocations :\(locations.last)")
        guard let location = locations.last  else {
            return
        }
        
        print("Altitude : \(location.altitude)")
        print("Altitude : \(location)")
        
//        delegate?.didUpdateLocation()
//
//        locationCompletionHandler?(location)
        
        
    }
    
//    func getChangeLocationData(completion: @escaping(_ location: CLLocation) -> Void) {
//
//        locationListener.bind(completion)
//
//    }
    
}



