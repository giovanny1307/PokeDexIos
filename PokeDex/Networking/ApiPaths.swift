//
//  UrlPaths.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation

struct ApiPaths {
    
    static let rootUrl  = "https://pokeapi.co/api/v2"
    static let pokemons = "\(rootUrl)/pokemon"
    
    func getPicturePath(_ pokemonNumber:String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonNumber).png"
    }

}
