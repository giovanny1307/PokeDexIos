//
//  SpritesCell.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class SpritesCell: UITableViewCell {

    @IBOutlet weak var labelNormal: UILabel!
    @IBOutlet weak var labelShiny: UILabel!
    @IBOutlet weak var imgNormal: UIImageView!
    @IBOutlet weak var imgShiny: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 40
    }
    
    func configure(_ color:UIColor, _ pokemon:Pokemon) {
        imgNormal.setupImage(photoUrl: pokemon.spriteFrontDefault)
        imgShiny.setupImage(photoUrl:
            pokemon.spriteFrontShiny)
        labelNormal.textColor = color
        labelShiny.textColor = color
        
        
    }
    

    
}
