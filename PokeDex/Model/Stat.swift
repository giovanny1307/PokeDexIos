//
//  Stat.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper


class Stat:Mappable {
    
    required convenience init?(map: Map) { self.init() }
    
    var name:String?
    var baseStat:Int?
    var efford:Int?
    
    func mapping(map: Map) {
        name <- map["stat.name"]
        baseStat <- map["base_stat"]
        efford <- map["effort"]
    }
}
