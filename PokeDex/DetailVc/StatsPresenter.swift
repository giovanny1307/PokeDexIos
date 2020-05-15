//
//  StatsPresenter.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation

protocol StatsProtocol:class {
    func getPokemon(_ pokemon:Pokemon)
    func showLoader()
    func hideLoader()
    func showError(_ error:String)
}

class StatsPresenter {
    fileprivate var pokemon:Pokemon?
    fileprivate var sProtocol:StatsProtocol?
    
    init(_ sProtocol:StatsProtocol, _ inputPokemon: Pokemon) {
        self.sProtocol = sProtocol
        self.pokemon = inputPokemon
    }
    
    func loadData() {
        sProtocol?.showLoader()
        pokemon?.getPokemonAbilities(complete: { (abilities, error) in
            
            guard error == nil, abilities != nil else {
                self.sProtocol?.showError(error!)
                return
            }
            
            self.pokemon?.getPokemonSpeciesInfo(complete: { (error) in
                self.sProtocol?.hideLoader()
                guard error == nil else {
                    self.sProtocol?.showError(error!)
                    return
                }
                
                
                self.sProtocol?.getPokemon(self.pokemon!)
            })
        })
    }
}


