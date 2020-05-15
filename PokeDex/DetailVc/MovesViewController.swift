//
//  MovesViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class MovesViewController: BaseStaticTVC {
    
    var pokemon:Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFooter()
        self.tableView.allowsSelection  = false
        loadCells()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
    
    func loadCells() {
        
        
        guard let myPokemon = pokemon else {
            return
        }
        
        var colorCell = UIColor.black
        
        if let types = myPokemon.types {
            
            if let type = types.last, let colors = type.getTypeColor() {
                colorCell = colors[1]
            }
        }
        
        if let ab = myPokemon.moves {
            guard ab.count > 0 else {
                return
            }
        
            for a in ab {
                var _:AbilitiesCell = appendRow() {
                    if let name = a.name {
                        $0.configure(name, "", colorCell)
                    }
                }
            }
        }
        
        reloadTableView()
    }
    
}
