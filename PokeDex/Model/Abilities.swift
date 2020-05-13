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
    
    func mapping(map: Map) {
        name <- map["ability.name"]
    }
}
