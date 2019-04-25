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
    var inputKeyword: String
    var apiKey: String
    var location: String
    var radius: String
    var urlString: String
    
}

class GoogleApiManager {
    
    public static var shared = GoogleApiManager()
    
    /// Description: common url request function
    ///
    /// - Parameters:
    ///   - type: model type
    ///   - request: url request (urlComponent is required)
    ///   - completion: return related type model
    func autoCompleteResult<T:Codable>(type: T.Type, request: URLRequest, completion: @escaping (Result<T, Error>) -> Void){
        
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
        
        switch googleApiCallStruct.callType {
        case .autoComplete:
            
            var urlComponent = URLComponents(string: googleApiCallStruct.urlString)
            
            urlComponent?.queryItems = [URLQueryItem(name: "input", value: googleApiCallStruct.inputKeyword), URLQueryItem(name: "key", value: googleApiCallStruct.apiKey), URLQueryItem(name: "location", value: googleApiCallStruct.location), URLQueryItem(name: "radius", value: googleApiCallStruct.radius)]
    
            return URLRequest(url: urlComponent!.url!)
            
        case .search:
            break;

        }
        
        return nil
        
    }
    
}
