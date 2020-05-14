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
    

    func getTypeColor() -> [UIColor]? {
           
           guard let myType = name else {
               return nil
           }
         
           switch myType {
           case "water":
            return Tools.getGradientColorsArray("#69B9E3", "#559EDF")
           case "normal":
            return Tools.getGradientColorsArray("#A3A49E", "#9298A4")
           case "fighting":
             return Tools.getGradientColorsArray("#E74347", "#CE4265")
           case "flying":
             return Tools.getGradientColorsArray("#A6C2F2", "#90A7DA")
           case "poison":
            return Tools.getGradientColorsArray("#C261D4", "#A864C7")
           case "ground":
               return Tools.getGradientColorsArray("#D29463", "#DC7545")
           case "rock":
              return Tools.getGradientColorsArray("#D7CD90", "#C5B489")
           case "bug":
              return Tools.getGradientColorsArray("#C5D86C", "#92BC2C")
           case "ghost":
                return Tools.getGradientColorsArray("#7773D4", "#516AAC")
           case "steel":
               return Tools.getGradientColorsArray("#58A6AA", "#52869D")
           case "fire":
              return Tools.getGradientColorsArray("#FBAE46", "#FB9B51")
           case "grass":
                return Tools.getGradientColorsArray("#5AC178", "#5FBC51")
           case "electric":
             return Tools.getGradientColorsArray("#FBE273", "#EDD53E")
           case "psychic":
                 return Tools.getGradientColorsArray("#FE9F92", "#F66F71")
           case "ice":
                 return Tools.getGradientColorsArray("#8CDDD4", "#70CCBD")
           case "dragon":
                 return Tools.getGradientColorsArray("#0C69C8", "#0180C7")
           case "dark":
               return Tools.getGradientColorsArray("#595761", "#6E7587")
           case "fairy":
                 return Tools.getGradientColorsArray("#F3A7E7", "#EC8CE5")
           default:
               return nil
           }
           
       }
    
    
   
}



 

