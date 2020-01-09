//
//  Networking.swift
//  app-list
//
//  Created by Jonathan Macias on 1/7/20.
//  Copyright © 2020 jonathan. All rights reserved.
//

import Foundation
import Alamofire



enum Result<Value> {
    case sucess(Value)
    case failure(Error)
}

class Networking: Constants{
    
    
    func getAppsList( completion: @escaping (([[String: Any]]) -> Void) ) {
        
        Alamofire.request(URL_API, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            do {
                
                let result = response.value as! [String: Any]
                
                let feeds = result["feed"] as! [String: Any]
                let apps = feeds["entry"] as! [[String: Any]]
                
                
                //print(apps)
                
                completion(apps)
            } catch {
                print("Error")
            }
            
        }
        
    }
    
}
