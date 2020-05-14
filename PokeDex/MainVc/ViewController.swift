//
//  ViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 12/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    
    enum Segues {
         static let toStats = "toDetail"
     }
     
    
    var pokemons = [Pokemon]()
    let cellIdentifier = "pokemonTableViewCell"
    
    var searchController:UISearchController?
    var reloadButton:UIBarButtonItem?
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var presenter:ViewControllerPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        configureReloadButton()
        hideNavBarButton()
        configurePresenter()
        presenter?.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configurePresenter(){
        presenter = ViewControllerPresenter(self)
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
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
    }
    
    func configureReloadButton() {
        reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(buttonTaped))
        self.navigationItem.rightBarButtonItem = reloadButton
    }
    
    func hideNavBarButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = .clear
    }
    
    func showNavBarButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func buttonTaped() {
        presenter?.buttonReloadTappedAction()
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
        presenter?.callNextPage(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SeguesTool.goToDetailVc(pokemons[indexPath.row], self)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.handleSearchBarInteraction(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.handleSearchBarInteraction("")
    }
}

extension ViewController:ViewControllerProtocol {
    
    func getPokemons(_ pokemons: [Pokemon], isFromSearchQuery: Bool) {
        
        if (isFromSearchQuery) {
            self.pokemons.removeAll()
        }
        
        self.pokemons.append(contentsOf: pokemons)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    
    func showReloadButton() {
        showNavBarButton()
    }
    
    func hideReloadButton() {
        hideNavBarButton()
    }
}
