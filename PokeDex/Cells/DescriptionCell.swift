//
//  DescriptionCell.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var imageDescType: UIImageView!
    @IBOutlet weak var descPoke: UILabel!
    
    var pokemon: Pokemon? {
          didSet {
              configureCell()
          }
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        if let desc = pokemon?.description {
            descPoke.text = desc
        }
        
        setTypeImages()
    }
    
    func setTypeImages() {
        
        guard let types = pokemon?.types else {
            return
        }
        
        if let t = types.last, let type1Img = t.getTypeLargeIcon() {
            imageDescType.image = type1Img
        }

    }
    
}
