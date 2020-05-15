//
//  EvoViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class EvoViewController: BaseStaticTVC {

   var pokemon:Pokemon?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          Tools.myPrintTool("From Evo, pokemon name=> ?", pokemon?.name)
          hideFooter()
      }

}
