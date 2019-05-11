//
//  Place.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//


import Foundation
import CoreLocation

class Place: ARAnnotation {
    let reference: String
    let placeName: String
    let address: String
    var phoneNumber: String?
    var website: String?
    var rating: Double?
    
    var infoText: String {
        get {
            var info = "Address: \(address)"
            
            if phoneNumber != nil {
                info += "\nPhone: \(phoneNumber!)"
            }
            
            if website != nil {
                info += "\nweb: \(website!)"
            }
            return info
        }
    }
    
    init(location: CLLocation, reference: String, name: String, address: String, rating: Double? = nil) {
        placeName = name
        self.reference = reference
        self.address = address
        self.rating = rating
        
        super.init()
        
        self.location = location
    }
    
    override var description: String {
        return placeName
    }
}
