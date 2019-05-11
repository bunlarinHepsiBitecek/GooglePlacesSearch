//
//  GoogleApiManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/25/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

struct GoogleApiCallStruct {
    
    var callType: GoogleApiCallTypes
    var keyword: String
    var apiKey: String? = nil
    var location: String? = nil
    var radius: String? = nil
    var urlString: String? = nil
    
    init(callType: GoogleApiCallTypes, keyword: String) {
        self.callType = callType
        self.keyword = keyword
    }
    
    init(callType: GoogleApiCallTypes, keyword: String, location: String, radius: String) {
        self.callType = callType
        self.keyword = keyword
        self.apiKey = CONSTANT.GOOGLE_KEYS.API_DATA.API_KEY
        self.location = location
        self.radius = radius
        
        switch callType {
        case .searchByKeyword:
            urlString = CONSTANT.GOOGLE_KEYS.URLS.SEARCH_WITH_KEYWORD
            break
        case .searchByTpye:
            urlString = CONSTANT.GOOGLE_KEYS.URLS.SEARCH_WITH_TYPE
            break
        default:
            break
        }
    }
    
}

class GoogleApiManager {
    
    public static var shared = GoogleApiManager()
    
    /// Description: common url request function
    ///
    /// - Parameters:
    ///   - type: model type
    ///   - request: url request (urlComponent is required)
    ///   - completion: return related type model
    func connectGoogleAPI<T:Codable>(type: T.Type, request: URLRequest, completion: @escaping (Result<T, Error>) -> Void){
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error : \(error)")
            }
            
            if let data = data {
                do {
                    let dataDecoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataDecoded))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(BackendApiError.missingDataError))
            }
            
        }
        
        task.resume()
        
    }
    
    /// Description: creates url request for google api calls
    ///
    /// - Parameter googleApiCallStruct: required attributes to create url components and request
    /// - Returns: Url request
    func createUrlRequest(googleApiCallStruct: GoogleApiCallStruct) -> URLRequest? {
        
        guard let urlString = googleApiCallStruct.urlString else { return nil }
        
        var urlComponent = URLComponents(string: urlString)
        
        switch googleApiCallStruct.callType {
        case .autoComplete:
            
            urlComponent?.queryItems = [URLQueryItem(name: "input", value: googleApiCallStruct.keyword), URLQueryItem(name: "key", value: googleApiCallStruct.apiKey), URLQueryItem(name: "location", value: googleApiCallStruct.location), URLQueryItem(name: "radius", value: googleApiCallStruct.radius)]
    
            return URLRequest(url: urlComponent!.url!)
            
        case .searchByTpye:
            
            urlComponent?.queryItems = [URLQueryItem(name: "type", value: googleApiCallStruct.keyword), URLQueryItem(name: "key", value: googleApiCallStruct.apiKey), URLQueryItem(name: "location", value: googleApiCallStruct.location), URLQueryItem(name: "radius", value: googleApiCallStruct.radius)]
            
            return URLRequest(url: urlComponent!.url!)

        case .searchByKeyword:
            
            urlComponent?.queryItems = [URLQueryItem(name: "keyword", value: googleApiCallStruct.keyword), URLQueryItem(name: "key", value: googleApiCallStruct.apiKey), URLQueryItem(name: "location", value: googleApiCallStruct.location), URLQueryItem(name: "radius", value: googleApiCallStruct.radius)]
            
            return URLRequest(url: urlComponent!.url!)
            
        }
        
    }
    
}
