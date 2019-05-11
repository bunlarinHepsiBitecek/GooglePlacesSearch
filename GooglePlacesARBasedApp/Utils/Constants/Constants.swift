
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
        static var DISTANCE_FILTER_50 : Double = 50.0
        static var ZOOM_DEGREE_002 : Double = 0.02
        static var ZOOM_DEGREE_0_0025 : Double = 0.0025
        static var ZOOM_DEGREE_0_005 : Double = 0.005
        static var ZOOM_DEGREE_0_01 : Double = 0.01
        static var ZOOM_DEGREE_0_05 : Double = 0.05
        static var ZOOM_DEGREE_0_025 : Double = 0.025
        static var RADIUS_01 : Double = 0.10
    }
    
    struct GOOGLE_KEYS {
        struct URLS {
            static var AUTO_COMPLETE_URL : String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
            static var SEARCH_WITH_TYPE : String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
            static var SEARCH_WITH_KEYWORD : String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        }
        struct API_DATA {
            static var API_KEY : String = "AIzaSyCaP456ugwzQ5P2OAC7bNDI1tlvLD4Qmjg"
        }
        struct API_CALL_PARAMETERS {
            static var RADIUS_1500 : String = "1500"
        }
    }
}
