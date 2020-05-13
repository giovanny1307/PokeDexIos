//
//  ViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemons = [Pokemon]()
    let cellIdentifier = "pokemonTableViewCell"
    
    var searchController:UISearchController?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        configureSearchController()
        configureTableView()
        loadData(0)
        
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "PokemonCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 83
        tableView.allowsSelection = false
        //tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PokemonCell
        let pokemon = pokemons[indexPath.row]
        cell.pokemon = pokemon
        if (indexPath.row == (pokemons.count - 3)){
            loadData(pokemons.count)
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension ViewController {
    func loadData(_ offset:Int) {
        Pokemon.listPokemons(offset: offset) { (pokemons, error) in
            if let myPokemons = pokemons {
                self.pokemons.append(contentsOf: myPokemons)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
