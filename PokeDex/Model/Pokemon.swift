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
    var speciesUrl:String?
    var description:String?
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
        speciesUrl <- map["species.url"]
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
            .request(ApiPaths.pokemons,parameters: params,encoding: URLEncoding(destination: .queryString)).responseArray(queue: .global(qos: .userInitiated), keyPath: "results", context: nil) {
                
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
                complete(nil,error)
                return
            }
            
            if let pokemon = response.value {
                complete(pokemon,nil)
            }
        }
    }
    
    func getPokemonSpeciesInfo(complete:@escaping(String?) -> Void) {
        guard let url = self.speciesUrl else {
            complete("no species url")
            return
        }
        
        PokemonDataService.request(url).validate().responseJSON { (response) in
            guard response.error == nil else {
                complete(response.error?.errorDescription)
                return
            }
            
            guard let dictionary = response.value as? [String:Any] else {
                complete("error in species response")
                return
            }
          
            guard let innerArray = dictionary["flavor_text_entries"] as? [Any] else {
                complete("error in species response")
                return
            }
            
            guard let innerDictionary = innerArray[1] as? [String:Any] else {
                complete("error in species response")
                return
            }
            
            guard let mySpeciesDescription = innerDictionary["flavor_text"] as? String else {
                complete("error in species response")
                return
            }
            
            self.description = mySpeciesDescription
            complete(nil)
        }
        
    }
    
    
    func getPokemonAbilities(complete:@escaping([Ability]?,String?) -> Void) {
        
        
        guard let abilities = self.abilities else {
            complete(nil,"the pokemon has no abilites")
            return
        }
        
        let dGroup = DispatchGroup()
        var abilityResponse = [Ability]()
        var dError:String?
        
        for ability in abilities {
            
            guard let _ = ability.url else {
                complete(nil,"the url is not found")
                return
            }
            dGroup.enter()
            
            ability.getAbilityDetails { (abilityUpd, error) in
                
                guard error == nil else {
                    dError = error
                    dGroup.leave()
                    return }
                
                if let myAbility = abilityUpd {
                    abilityResponse.append(myAbility)
                    dGroup.leave()
                }
           
            }
        }
        
        dGroup.notify(queue: .main) {
            if let disError = dError  {
                complete(nil,disError)
            } else {
                self.abilities = abilityResponse
                complete(abilityResponse,dError)
            }
        }
    }
}


