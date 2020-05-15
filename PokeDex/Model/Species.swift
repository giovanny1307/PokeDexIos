//
//  Species.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Species:Mappable {
    
    required convenience init?(map: Map) { self.init() }
    
    var name:String?
    var url:String?
    
    func mapping(map: Map) {
        name <- map["species.name"]
        url <- map["species.url"]
    }
}
