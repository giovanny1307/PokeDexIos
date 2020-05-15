//
//  AbilitiesCell.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 14/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit

class AbilitiesCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var complementaryText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ name:String, _ cText:String = "", _ color:UIColor) {
        labelName.textColor = color
        labelName.text = name
        complementaryText.text = cText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
