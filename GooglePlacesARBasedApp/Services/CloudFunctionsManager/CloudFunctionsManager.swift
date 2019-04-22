//
//  CloudFunctionsManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/21/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class CloudFunctionsManager {
    
    public static var shared = CloudFunctionsManager()
    
    func getPlaceCategories<T:Codable>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        print("\(#function) starts")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                print("error : \(error)")
                completion(.failure(error))
            }
            
            print("response : \(String(describing: urlResponse))")
            
            guard let data = data else {
                return
            }
            
            do {
                let parsedJsonData = try JSONDecoder().decode(type.self, from: data)
                
                print("parsedJsonData : \(parsedJsonData)")
                completion(.success(parsedJsonData))
                
            } catch let error {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
    }
    
    
}


