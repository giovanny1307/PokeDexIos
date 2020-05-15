//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var labelNamePokemon: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    lazy var statsIsLoaded = false
    lazy var evoIsLoaded = false
    lazy var movesIsLoaded = false
    
    var pokemon:Pokemon?
    var colors:[UIColor]?
    
    private lazy var statsVc: StatsViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "StatsVc") as! StatsViewController
        viewController.pokemon = self.pokemon
        self.addChildVc(viewController)
        self.statsIsLoaded = true
        return viewController
    }()
    
    private lazy var evoVc: EvoViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "EvoVc") as! EvoViewController
        viewController.pokemon = self.pokemon
        self.addChildVc(viewController)
        self.evoIsLoaded = true
        return viewController
    }()
    
    private lazy var movesVc: MovesViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MovesVc") as! MovesViewController
        viewController.pokemon = self.pokemon
        self.addChildVc(viewController)
        self.movesIsLoaded = true
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
    
        configureTabBar()
        configureHeaderView()
        loadInfoToHeader()
        configureBackgroundColor()
        configureSegmentedControl()
        addChildVc(statsVc)

    }
    
    func loadInfoToHeader() {
        labelNamePokemon.text = pokemon?.name!.capitalized
        imageViewPokemon.setupImage(photoUrl: pokemon?.spriteFrontDefault)
        
    }
    
    func configureTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureHeaderView() {
        self.headerView.layer.cornerRadius = 40
        self.headerView.clipsToBounds = true
    }
    
    func configureBackgroundColor() {
        if let types = pokemon?.types {
            
            guard let myType = types.last else{
                return
            }
            
            if let myColors = myType.getTypeColor() {
                self.colors = myColors
                self.view.setGradientBackground(myColors)
            }
        }
    }
}

// MARK: - Segmentend control actions and methods

extension DetailViewController {
    
    private func configureSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Stats", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Evolutions", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Moves", at: 2, animated: false)
    
        var selectedAtt = [NSAttributedString.Key.foregroundColor: UIColor.black]
        var nonSelectedAtt = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if let colors = self.colors {
            segmentedControl.selectedSegmentTintColor = colors[1]
            selectedAtt = [NSAttributedString.Key.foregroundColor: UIColor.white]
            nonSelectedAtt = [NSAttributedString.Key.foregroundColor: colors[0]]
            
        }
        
        segmentedControl.setTitleTextAttributes(selectedAtt, for: .selected)
        segmentedControl.setTitleTextAttributes(nonSelectedAtt, for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        setSegment()
    }
    
    private func setSegment() {
        let segmentIndex = segmentedControl.selectedSegmentIndex
        
        removeControllers(segmentIndex)
        
        switch segmentIndex {
        case 0:
            addChildVc(statsVc)
        case 1:
            addChildVc(evoVc)
        case 2:
            addChildVc(movesVc)
        default:
            print("no action")
        }
        
    }
    
    private func removeControllers(_ index:Int){
        switch index {
        case 0:
            if (movesIsLoaded) {
                removeChildVc(movesVc)
            }
            if (evoIsLoaded){
                removeChildVc(evoVc)
            }
        case 1:
            if (statsIsLoaded) {
                removeChildVc(statsVc)
            }
            if (movesIsLoaded){
                removeChildVc(movesVc)
            }
        case 2:
            if (statsIsLoaded) {
                removeChildVc(statsVc)
            }
            if (evoIsLoaded){
                removeChildVc(evoVc)
            }
        default:
            print("no action")
        }
    }
    
    
    
    private func addChildVc(_ vc: UIViewController) {
        
        addChild(vc)
        self.containerView.addSubview(vc.view)
        vc.view.frame = containerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }
    
    private func removeChildVc(_ vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
}
