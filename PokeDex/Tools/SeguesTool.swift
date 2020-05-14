//
//  SeguesTool.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import UIKit

class SeguesTool {
    
    class func goToDetailVc(_ pokemon:Pokemon, _ presenterVc: UIViewController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailVc = storyboard.instantiateViewController(identifier: "detailVc") as! DetailViewController
        detailVc.pokemon = pokemon
        presenterVc.show(detailVc, sender: presenterVc)

    }
    
}
