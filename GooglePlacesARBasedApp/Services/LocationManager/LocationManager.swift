//
//  LocationManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/18/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

//class LocationManager: NSObject, CLLocationManagerDelegate {
//
//    public static var shared = LocationManager()
//
//
//    // 41.10773,29.030638
//
//
//}

protocol LocationManagerDelegate: class {
    func didUpdateLocation()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationListener = Dynamic(CLLocation())
    
    var locationCompletionHandler:((_ x : CLLocation) -> Void)?
    
    var counter = 0
    
    public static let shared = LocationManager()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    weak var delegate: LocationManagerDelegate!
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        locationAuthorizationCheck()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.distanceFilter = Constants.Map.DistanceFilter
        locationManager.allowsBackgroundLocationUpdates = true // Enable background location updates
        locationManager.pausesLocationUpdatesAutomatically = true // Enable automatic pausing
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization tetiklendi")
        //        self.locationAuthorizationCheck()
    }
    
    // MARK: check location auth options
    func locationAuthorizationCheck() {
        let status  = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse :
            break
        case .denied, .restricted:
            //self.permissionAlert()
            break
        case .notDetermined :
            locationManager.requestAlwaysAuthorization()
            break
        }
    }
    
//    func permissionAlert() {
//        AlertViewManager.shared.createAlert(title: LocalizedConstants.Location.LocationServiceDisableTitle, message: LocalizedConstants.Location.LocationServiceDisable, preferredStyle: .alert, actionTitleLeft: LocalizedConstants.Location.Settings, actionTitleRight: LocalizedConstants.Location.Ok, actionStyle: .default, completionHandlerLeft: { (action) in
//            LoaderController.shared.goToSettings()
//        }, completionHandlerRight: nil)
//    }
    
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
        print("Remzi didUpdateLocations :\(locations.last)")
        guard let location = locations.last  else {
            return
        }
        
        print("Altitude : \(location.altitude)")
        print("Altitude : \(location)")
        
        //        if let currentLocation = currentLocation {
        //            if (location.coordinate.longitude == currentLocation.coordinate.longitude &&
        //                location.coordinate.latitude == currentLocation.coordinate.latitude) && !externalViewInitialize {
        //                return
        //            }
        //        }
        
        counter = counter + 1
        
        print("counter : \(counter)")
        
        self.currentLocation = location
        
        delegate?.didUpdateLocation()
        
        locationCompletionHandler?(location)
        
        
    }
    
    func moko() {
        
    }
    
    func getChangeLocationData(completion: @escaping(_ location: CLLocation) -> Void) {
        
        locationListener.bind(completion)
        
    }
    
}



