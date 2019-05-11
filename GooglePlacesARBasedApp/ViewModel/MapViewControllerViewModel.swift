//
//  MapViewControllerViewModel.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit

class MapViewControllerViewModel {
    
    var googleSearchResultData = Dynamic([GoogleSearchResult]())
    var googleApiResult = Dynamic(ApiCallStatus.none)
    
    private var placeAnnotationData = Array<Place>()
    
    func getDataFromGooglePlacesApi(apiCallData: GoogleApiCallStruct) {
        
        googleApiResult.value = .process
        
        LocationManager.shared.getCurrentLocationData { (location) in
            
            guard let urlRequest = self.createUrlRequest(location, apiCallData) else { return }
            
            GoogleApiManager.shared.connectGoogleAPI(type: SearchResult.self, request: urlRequest, completion: { (googleSearchResult) in
                
                switch googleSearchResult {
                case .failure(let error):
                    print("error : \(error)")
                    break
                case .success(let data):
                    for item in data.results {
                        print("item : \(item.name)")
                    }
                    self.googleSearchResultData.value = data.results
                    self.convertGoogleSearchResultDataToPlaceAnnotationData(data: data.results)
                    break
                }
                
            })
            
        }
        
    }
    
    func returnLocationLatLngAsString(location: CLLocation) -> String {
        print("Location : \(location)")
        let locationStringData = String(describing: location.coordinate.latitude) + "," + String(describing: location.coordinate.longitude)
        print("locationStringData : \(locationStringData)")
        return locationStringData
    }
    
    private func createUrlRequest(_ location: CLLocation, _ apiCallData: GoogleApiCallStruct) -> URLRequest? {
        return GoogleApiManager.shared.createUrlRequest(googleApiCallStruct: self.returnAdditionalData(apiCallData: apiCallData, location: self.returnLocationLatLngAsString(location: location), radius: CONSTANT.GOOGLE_KEYS.API_CALL_PARAMETERS.RADIUS_1500))
    }
    
    private func returnAdditionalData(apiCallData: GoogleApiCallStruct, location: String, radius: String) -> GoogleApiCallStruct {
        return GoogleApiCallStruct(callType: apiCallData.callType, keyword: apiCallData.keyword, location: location, radius: radius)
    }
    
    private func convertGoogleSearchResultDataToPlaceAnnotationData(data: Array<GoogleSearchResult>) {
        
        placeAnnotationData.removeAll()
        
        for item in data {
            let placeAnnotation = Place(location: CLLocation(latitude: item.geometry.location.lat, longitude: item.geometry.location.lng), reference: item.reference, name: item.name, address: item.vicinity, rating: item.rating)
            
            placeAnnotationData.append(placeAnnotation)
            
        }
        
    }
    
    func returnPlacesAnnotationData() -> Array<Place> {
        return self.placeAnnotationData
    }
    
}

/*
 GoogleApiManager.shared.connectGoogleAPI(type: SearchResult.self, request: GoogleApiManager.shared.createUrlRequest(googleApiCallStruct: GoogleApiCallStruct(callType: .search, inputKeyword: nil, placeType: "restaurant", apiKey: CONSTANT.GOOGLE_KEYS.API_DATA.API_KEY, location: locationStringData, radius: CONSTANT.GOOGLE_KEYS.API_CALL_PARAMETERS.RADIUS_1500, urlString: CONSTANT.GOOGLE_KEYS.URLS.SEARCH_WITH_TYPE))!, completion: { (googleSearchResult) in
 
 switch googleSearchResult {
 case .failure(let error):
 print("error : \(error)")
 case .success(let data):
 
 for item in data.results {
 print("item : \(item.name)")
 }
 
 self.tempGoogleSearchResult = data.results
 
 DispatchQueue.main.async {
 for item in self.tempGoogleSearchResult {
 
 let temp = GoogleSearchResultAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.geometry.location.lat, longitude: item.geometry.location.lng), title: item.name)
 self.mapView.addAnnotation(temp)
 
 }
 }
 
 break
 }
 
 })*/
