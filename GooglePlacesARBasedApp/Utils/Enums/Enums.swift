//
//  Enums.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/23/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

enum PermissionButtonStyle {
    case locationRequest
    case locationAccessed
    case locationEnable
    case cameraRequest
    case cameraAccessed
    case cameraEnable
}

enum PermissionType {
    case location
    case camera
}

enum PermissionResult {
    case notDetermined
    case denied
    case authorized
}

enum BackendApiError: Error {
    case missingDataError
    case parseDataError
}

enum GoogleApiCallTypes {
    case autoComplete
    case search
}
