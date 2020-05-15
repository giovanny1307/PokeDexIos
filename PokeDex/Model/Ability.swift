//
//  Abilities.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper


class Ability:Mappable {
    
    required convenience init?(map: Map) { self.init() }
    
    var name:String?
    var url:String?
    var effect:String?
    var id:Int?
    var name2:String?
    
    func mapping(map: Map) {
        name <- map["ability.name"]
        url <- map["ability.url"]
    }
    
    func getAbilityDetails(complete: @escaping (Ability?, String?) -> Void) {
        
        guard let myUrl = self.url else {
            return
        }
    
        PokemonDataService.request(myUrl).validate().responseJSON { (response) in
            
            guard response.error == nil else {
                print(response.error?.errorDescription)
                complete(nil,response.error?.errorDescription)
                return
            }
            
            guard let dictionary = response.value as? [String:Any] else {
                complete(nil,"error in ability response")
                return
            }
            
            guard let innerArray = dictionary["effect_entries"] as? [Any] else {
                complete(nil,"error in ability response")
                return
            }
            
            guard let innerDictionary = innerArray[0] as? [String:Any] else {
                complete(nil,"error in ability response")
                return
            }
            
            guard let myEffect = innerDictionary["effect"] as? String else {
                complete(nil,"error in ability response")
                return
            }
            
            
    
            self.effect = myEffect
            
          
            complete(self,nil)
        }
    }
}
