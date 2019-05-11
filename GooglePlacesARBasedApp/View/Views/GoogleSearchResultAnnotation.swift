//
//  GoogleSearchResultAnnotation.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class GoogleSearchResultAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = title
        super.init()
        
    }
    
}

class GoogleSearchResultMarkerAnnotationView: MKMarkerAnnotationView {
 
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        animatesWhenAdded = true
//        markerTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setMarkerColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setMarkerColor() {
        let randomNumber = Int.random(in: 1 ..< 5)
        
        if randomNumber == 1 {
            markerTintColor = #colorLiteral(red: 0.3901466727, green: 0.3557243347, blue: 1, alpha: 1)
        } else if randomNumber == 2 {
            markerTintColor = #colorLiteral(red: 0.3097541928, green: 0.4549607635, blue: 1, alpha: 1)
        } else if randomNumber == 3 {
            markerTintColor = #colorLiteral(red: 0, green: 0.6021857858, blue: 1, alpha: 1)
        } else if randomNumber == 4 {
            markerTintColor = #colorLiteral(red: 0, green: 0.8138262033, blue: 0.8954362273, alpha: 1)
        } else {
            markerTintColor = #colorLiteral(red: 0.3901466727, green: 0.3557243347, blue: 1, alpha: 1)
        }
    }
    
}

