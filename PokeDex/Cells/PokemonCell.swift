//
//  PokemonCell.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonCell: UITableViewCell {
    @IBOutlet weak var imageViewPokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var idPokemon: UILabel!
    @IBOutlet weak var type2Pokemon: UIImageView!
    @IBOutlet weak var type1Pokemon: UIImageView!
    
    var pokemon: Pokemon? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewPokemon.contentMode = .scaleAspectFill
        self.imageViewPokemon.clipsToBounds = true
        self.type2Pokemon.isHidden = true
        
    }
    
    override func prepareForReuse() {
        self.namePokemon.text = ""
        self.idPokemon.text = ""
        self.type2Pokemon.isHidden = true
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        self.namePokemon.text = pokemon?.name!
        self.idPokemon.text = "# \(pokemon!.getId())"
        
        setupImage(photoUrl: pokemon?.spriteFrontDefault)
        setTypeImages()
    }
    
    func setTypeImages() {
        
        guard let types = pokemon?.types else {
            return
        }
        
        if let type1Img = types[0].getTypeSmallIcon() {
            type1Pokemon.image = type1Img
        }
        
        guard types.count == 2 else {
            return
        }
        
        if let type2Img = types[1].getTypeSmallIcon() {
            type2Pokemon.isHidden = false
            type2Pokemon.image = type2Img
        }
    }
    
    func setupImage(photoUrl: String?) {
        
        if let photoUrlString = photoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            
            self.imageViewPokemon.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "pokemon"))
        }
    }
    
    
    
}
