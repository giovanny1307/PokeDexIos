//
//  ViewControllerPresenter.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation

class ViewControllerPresenter {
    
    fileprivate var cachePokemonsArray = [Pokemon]()
    fileprivate var searchPokemonsArray = [Pokemon]()
    
    fileprivate var vcProtocol:ViewControllerProtocol?
    
    
    init(_ vcProtocol:ViewControllerProtocol) {
        self.vcProtocol = vcProtocol
    }
    
    func loadData(_ offset:Int = 0){
        self.vcProtocol?.showLoader()
        Pokemon.listPokemons(offset: offset) { (pokemons, error) in
            self.vcProtocol?.hideLoader()
            if let myError = error {
                self.vcProtocol?.showError(myError)
                return
            }
            
            if let myPokemons = pokemons {
                self.cachePokemonsArray.append(contentsOf: myPokemons)
                self.sendPokemonsToVc(myPokemons)
            }
        }
    }
    
    func callNextPage(_ indexRow:Int) {
        
        if (searchPokemonsArray.count>=1) {
            return
        }
        
        let offset = cachePokemonsArray.count
        
        if (indexRow == offset - 1) {
            loadData(offset)
        }
    }
    
    func handleSearchBarInteraction(_ searchText:String) {
        
        if (searchText.isEmpty) {
            
            if (searchPokemonsArray.isEmpty) {
                reloadCachedPokemons()
                vcProtocol?.hideReloadButton()
            } else {
                vcProtocol?.showReloadButton()
            }
        
            return
        }
        
        searchPokemonsArray.removeAll()
        
        if (filterCachedPokemons(searchText)) {
            print("pokemon stored locally")
            vcProtocol?.hideLoader()
            sendPokemonsToVc(self.searchPokemonsArray,true)
            
        } else {
            Pokemon.getPokemonByName(searchText.lowercased()) { (pokemon, error) in
               
                if let _ = error {
                    self.vcProtocol?.showReloadButton()
                }
                
                if let myPokemon = pokemon {
                    print("pokemon retreived from server")
                    self.searchPokemonsArray.append(myPokemon)
                }
                
                self.sendPokemonsToVc(self.searchPokemonsArray,true)
            }
        }
    }
    
    func buttonReloadTappedAction() {
        searchPokemonsArray.removeAll()
        reloadCachedPokemons()
        vcProtocol?.hideReloadButton()
    }
    
    func reloadCachedPokemons() {
        sendPokemonsToVc(self.cachePokemonsArray,true)
    }
    
    private func sendPokemonsToVc(_ pokemonsResult:[Pokemon], _ isFromSearch:Bool = false) {
           self.vcProtocol?.getPokemons(pokemonsResult, isFromSearchQuery: isFromSearch)
    }
    
    
    private func filterCachedPokemons(_ searchText:String) -> Bool {
        let searchTerms = searchText.components(separatedBy: " ").filter{ $0 != ""}
        var isInMyCachedPokemons = false
        self.searchPokemonsArray = cachePokemonsArray.filter({ (result) -> Bool in
            
            guard let value = result.name else {
                return false
            }
            
            let name = value.removeAccentsInSearch().lowercased()
            
            for term in searchTerms{
                let evaluation = name == term.removeAccentsInSearch().lowercased()
                if (!evaluation){
                    return false
                }
            }
            
            return true
        })
        
        if (searchPokemonsArray.count>=1) {
            isInMyCachedPokemons = true
        }
        
        return isInMyCachedPokemons
    }
    
    
}
