//
//  PermissionManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/18/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit
import Photos

class PermissionManager {
    
    public static var shared = PermissionManager()
    
    func startCheckingPermissions() {
        
        CLLocationManager.authorizationStatus()
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            // everything is ok go on
            break
        case .denied, .restricted:
            // location must be enabled from settings
            break
        case .notDetermined:
            // hmmm, ask user to be granted for location service
            //locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            fatalError()
        }
        
    }
    
    func checkRequiredPermissions(completion: @escaping(_ appCanGo: Bool) -> Void) {
        
    }
    
}
