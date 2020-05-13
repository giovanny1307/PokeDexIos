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
    
    required convenience init?(map: Map) { self.init() }
    
    var name:String?
    var urlDetail:String?
    var id:Int?
    var abilities:[Ability]?
    var baseExperience:Int?
    var moves:[Move]?
    var spriteFrontShiny:String?
    var spriteFrontDefault:String?
    var stats:[Stat]?
    var types:[Type]?
    var weight:Int?
    
    
    func mapping(map: Map) {
        name <- map["name"]
        urlDetail <- map["url"]
        id <- map["id"]
        abilities <- map["abilities"]
        baseExperience <- map["base_experience"]
        moves <- map["moves"]
        spriteFrontShiny <- map["sprites.front_shiny"]
        spriteFrontDefault <- map ["sprites.front_default"]
        stats <- map ["stats"]
        types <- map ["types"]
        weight <- map["weight"]
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
    
    class func listPokemons(offset:Int,complete: @escaping ([Pokemon]?, String?) -> Void) {
        
        let params: [String: Any] = ["offset": offset, "limit":10]
        var pokemonsResult = [Pokemon]()
        let dGroup = DispatchGroup()
        var errorDispatch:String?
        
        PokemonDataService
            .request(ApiPaths.pokemons,parameters: params,encoder: URLEncoding(destination: .queryString)).responseArray(queue: .global(qos: .userInitiated), keyPath: "results", context: nil) {
                
                (response:DataResponse<[Pokemon],AFError>) in
                
                if let error = response.error?.errorDescription {
                    print(error)
                    complete(nil,error)
                    return
                }
                
                if let myPokemons = response.value {
                    for pokemon in myPokemons {
                        
                        dGroup.enter()
                        
                        getPokemonById(pokemon.getId()) { (myPokemon, error) in
                            if let err = error {
                                errorDispatch = err
                                dGroup.leave()
                            }
                            
                            if let pokeResult = myPokemon {
                                pokemonsResult.append(pokeResult)
                                dGroup.leave()
                            }
                        }
                    }
                    
                    dGroup.notify(queue: .main) {
                        complete(pokemonsResult,errorDispatch)
                    }
                }
        }
        
        
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
                complete(pokemon,nil)
            }
            
        }
        
    }
    
    class func getPokemonById(_ id:Int,complete:@escaping(Pokemon?,String?) -> Void) {
        let url = "\(ApiPaths.pokemons)/\(id)"
        
        PokemonDataService.request(url).validate().responseObject { (response:DataResponse<Pokemon,AFError>) in
            
            if let error = response.error?.errorDescription {
                print(error)
                complete(nil,error)
                return
            }
            
            if let pokemon = response.value {
                complete(pokemon,nil)
            }
            
        }
    }
}


