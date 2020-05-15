//
//  PokemonDetails.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation

class PokemonDetailsApi {
    
    class func getPokemonAbilities(_ pokemon:Pokemon ,complete:@escaping([Ability]?,String?) -> Void) {
        
        
        guard let abilities = pokemon.abilities else {
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
            
            ability.getAbilityDetails { (ability, error) in
                
                guard let _ = error else {
                    dError = error
                    dGroup.leave()
                    return }
                
                if let myAbility = ability {
                    abilityResponse.append(myAbility)
                    dGroup.leave()
                }
            }
        }
        
        dGroup.notify(queue: .main) {
            if let disError = dError  {
                complete(nil,disError)
            } else {
                complete(abilityResponse,dError)
            }
        }
    }
    
}
