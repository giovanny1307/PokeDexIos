//
//  Pokemon.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Pokemon:Mappable {
    
    var name:String?
    var urlDetail:String?
    var id:Int?
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        name <- map["name"]
        urlDetail <- map["url"]
        id <- map["id"]
    }
    
    func getId() -> Int {
        var myId = 0
        
        if let id = self.id {
            myId = id
        }
        
        if let urlDet = self.urlDetail {
            let comp = urlDet.components(separatedBy: "/")
            myId = Int(comp[6]) ?? 0
        }
        
        return myId
    }
    
    class func getPokemonByName(_ searchName:String, complete:@escaping(Pokemon?,String?) -> Void) {
        
        let url = "\(ApiPaths.pokemons)/\(searchName)"
        
        PokemonDataService.request(url).validate().responseObject { (response:DataResponse<Pokemon,AFError>) in
            
            if let error = response.error?.errorDescription {
                               print(error)
                              
                                   complete(nil,error)
                               
                               return
                           }
            
            if let pokemon = response.value {
                
            }
            
        }
        
    }
    
    
    class func listPokemons(offset:Int,complete: @escaping ([Pokemon]?, String?) -> Void) {
        
        let params: [String: Any] = ["offset": offset, "limit":30]
        
        PokemonDataService
            .request(ApiPaths.pokemons,parameters: params,encoder: URLEncoding(destination: .queryString)).responseArray(queue: .global(qos: .background), keyPath: "results", context: nil) {
                
                (response:DataResponse<[Pokemon],AFError>) in
                
                if let error = response.error?.errorDescription {
                    print(error)
                    DispatchQueue.main.async {
                        complete(nil,error)
                    }
                    return
                }
                
                if let myPokemons = response.value {
                    DispatchQueue.main.async {
                        complete(myPokemons,nil)
                    }
                }
                
        }
    }
    
    
}


