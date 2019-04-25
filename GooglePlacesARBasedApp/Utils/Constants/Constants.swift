
//
//  Constants.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/25/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

struct CONSTANT {
    struct MAP_KIT_CONSTANT {
        static var DISTANCE_FILTER_10 : Double = 10.0
        static var ZOOM_DEGREE_002 : Double = 0.02
        static var ZOOM_DEGREE_0_0025 : Double = 0.0025
        static var RADIUS_01 : Double = 0.10
    }
    
    struct GOOGLE_KEYS {
        struct URLS {
            static var AUTO_COMPLETE_URL : String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        }
        struct API_DATA {
            static var API_KEY : String = ""
        }
    }
}
