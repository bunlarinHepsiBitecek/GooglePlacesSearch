//
//  ARAnnotation.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/8/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import CoreLocation

/// Defines POI with title and location.
open class ARAnnotation: NSObject
{
    /// Title of annotation
    open var title: String?
    /// Location of annotation
    open var location: CLLocation?
    /// View for annotation. It is set inside ARViewController after fetching view from dataSource.
    internal(set) open var annotationView: ARAnnotationView?
    
    // Internal use only, do not set this properties
    internal(set) open var distanceFromUser: Double = 0
    internal(set) open var azimuth: Double = 0
    internal(set) open var verticalLevel: Int = 0
    internal(set) open var active: Bool = false
    
}
