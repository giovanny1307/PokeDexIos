//
//  ViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ds:PokemonDataService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Pokemon.listPokemons(offset: 0) { (pokemons, error) in
            if let err = error {
                
            }
            
        }
    }


}

