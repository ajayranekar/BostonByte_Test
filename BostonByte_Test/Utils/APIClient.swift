//
//  APIClient.swift
//  BostonByte_Test
//
//  Created by Ajay Ranekar on 17/11/19.
//  Copyright © 2019 Ajay Ranekar. All rights reserved.
//

import Foundation

class APIClient {
    
    private init() { }
    
    class func getData(api: String, completion: @escaping ([[String: Any]]?) -> Void) -> Void {
        
        guard let url = URL.init(string: Constant.BASE_URL + api) else {
            print("Invalid url")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else {
              print("Error while fetching remote rooms: \(String(describing: error))")
                completion(nil)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                print("Nil data received from the server API")
                completion(nil)
                return
            }
            
            completion(json)
            
        }.resume()
        
    }
    
    class func postData(api: String, parameter: [String: Any], completion: @escaping ([[String: Any]]?) -> Void) -> Void {
        
        guard let url = URL.init(string: Constant.BASE_URL + api) else {
            print("Invalid url")
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil, let data = data else {
              print("Error while fetching remote rooms: \(String(describing: error))")
                completion(nil)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                print("Nil data received from the server API")
                completion(nil)
                return
            }
            
            completion(json)
            
        }.resume()
        
    }
    
}
