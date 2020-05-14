//
//  MovesViewController.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class MovesViewController: UIViewController {

      lazy var loaded = false

     override func viewDidLoad() {
          super.viewDidLoad()
          loaded = true
          // Do any additional setup after loading the view.
      }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        print("moves dissapear")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
