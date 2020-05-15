//
//  StatsCell.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {
    @IBOutlet weak var statTitle: UILabel!
    @IBOutlet weak var statValue: UILabel!
    @IBOutlet weak var graph: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confiugre(_ sName:String, sVal:Int, _ color:UIColor) {
        statTitle.textColor = color
        statTitle.text = sName
        statValue.text = "\(sVal)"
        let prg = Float(sVal)/100
        graph.progressTintColor = color
        graph.setProgress(prg, animated: true)
    }
    
}
