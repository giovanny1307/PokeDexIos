//
//  NetowrkService.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import Alamofire

class PokemonDataService {
    
    
    class func basicRequest(_ path:String) -> DataRequest {
        let finalUrl = ApiPaths.rootUrl+path
        return AF.request(finalUrl)
    }
    
    @discardableResult
    class func request(_ url: String,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       headers: HTTPHeaders? = nil,
                       encoder: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        
     
        
        return AF.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: encoder,
                          headers: headers,
                          interceptor: nil)
        
    }
    
    
   
    
    
    
}
