//
//  Type.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper


class Type:Mappable {
    
    required convenience init?(map: Map) { self.init() }
    
    var name:String?
    
    func mapping(map: Map) {
        name <- map["type.name"]
    }
    
    func getTypeSmallIcon() -> UIImage? {
        
        guard let myType = name else {
            return nil
        }
        
        switch myType {
        case "water":
            return UIImage(named:"t_water_s")
        case "normal":
            return UIImage(named:"t_normal_s")
        case "fighting":
            return UIImage(named:"t_fight_s")
        case "flying":
            return UIImage(named:"t_flying_s")
        case "poison":
            return UIImage(named:"t_poison_s")
        case "ground":
            return UIImage(named:"t_ground_s")
        case "rock":
            return UIImage(named:"t_rock_s")
        case "bug":
            return UIImage(named:"t_bug_s")
        case "ghost":
            return UIImage(named:"t_ghost_s")
        case "steel":
            return UIImage(named:"t_steel_s")
        case "fire":
            return UIImage(named:"t_fire_s")
        case "grass":
            return UIImage(named:"t_grass_s")
        case "electric":
            return UIImage(named:"t_electric_s")
        case "psychic":
            return UIImage(named:"t_psychic_s")
        case "ice":
            return UIImage(named:"t_ice_s")
        case "dragon":
            return UIImage(named:"t_dragon_s")
        case "dark":
            return UIImage(named:"t_dark_s")
        case "fairy":
            return UIImage(named:"t_fairy_s")
        default:
            return UIImage(named:"pokemon")
        }
    }
    
     func getTypeLargeIcon() -> UIImage? {
           guard let myType = name else {
               return nil
           }
           
           switch myType {
           case "water":
               return UIImage(named:"t_water_l")
           case "normal":
               return UIImage(named:"t_normal_l")
           case "fighting":
               return UIImage(named:"t_fight_l")
           case "flying":
               return UIImage(named:"t_flying_l")
           case "poison":
               return UIImage(named:"t_poison_l")
           case "ground":
               return UIImage(named:"t_ground_l")
           case "rock":
               return UIImage(named:"t_rock_l")
           case "bug":
               return UIImage(named:"t_bug_l")
           case "ghost":
               return UIImage(named:"t_ghost_l")
           case "steel":
               return UIImage(named:"t_steel_l")
           case "fire":
               return UIImage(named:"t_fire_l")
           case "grass":
               return UIImage(named:"t_grass_l")
           case "electric":
               return UIImage(named:"t_electric_l")
           case "psychic":
               return UIImage(named:"t_psychic_l")
           case "ice":
               return UIImage(named:"t_ice_l")
           case "dragon":
               return UIImage(named:"t_dragon_l")
           case "dark":
               return UIImage(named:"t_dark_l")
           case "fairy":
               return UIImage(named:"t_fairy_l")
           default:
               return UIImage(named:"pokemon")
           }
       }
}

