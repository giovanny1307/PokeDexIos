//
//  StatsViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit
import SVProgressHUD

class StatsViewController: BaseStaticTVC {
    
    fileprivate var presenter:StatsPresenter?
    var cell1:PokemonCell!
    var pokemon:Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFooter()
        configurePresenter()
        presenter?.loadData()
        self.tableView.separatorStyle = .none
    
      
        self.tableView.clipsToBounds = true
        self.tableView.allowsSelection  = false
        
    }
    
    func configurePresenter(){
        if let myPokemon = pokemon {
            presenter = StatsPresenter(self,myPokemon)
        }
    }
    
    func loadCells(_ myPokemon:Pokemon) {
        
        var colorCell = UIColor.black
        
        if let types = myPokemon.types {
            
            if let type = types.last, let colors = type.getTypeColor() {
                colorCell = colors[1]
            }
        }
        
        if let stats = myPokemon.stats {
            
            guard stats.count > 0 else {
                return
            }
            
            for st in stats {
                guard let name = st.name, let val = st.baseStat else {return}
                
                var _:StatsCell = appendRow() {
                    $0.confiugre(name, sVal: val,colorCell)
                }
            }
        }
        
        if let _ = myPokemon.description {
            
            var _:TitleCell = appendRow() {
                $0.setTitle("Characteristics",colorCell)
            }
            
            var _:DescriptionCell = appendRow() {
                $0.pokemon = myPokemon
            }
        }
        
        if let ab = myPokemon.abilities {
            guard ab.count > 0 else {
                return
            }
            
            var _:TitleCell = appendRow() {
                $0.setTitle("Abilites",colorCell)
            }
            
            for a in ab {
                var _:AbilitiesCell = appendRow() {
                    if let name = a.name, let cT = a.effect {
                        $0.configure(name, cT,colorCell)
                    }
                }
            }
        }
        
        var _:TitleCell = appendRow() {
            $0.setTitle("Sprites",colorCell)
        }
        
        var _:SpritesCell = appendRow() {
            $0.configure(colorCell, myPokemon)
        }
        
        reloadTableView()
        
        
    }
    
    
}

extension StatsViewController:StatsProtocol {
    
    func getPokemon(_ pokemon: Pokemon) {
        loadCells(pokemon)
    }
    
    func showError(_ error: String) {
        SVProgressHUD.showError(withStatus: "😵\n\(error)")
    }
    
    func showLoader() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
}
