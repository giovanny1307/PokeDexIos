//
//  Extensions.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
import UIKit

extension String {
  
    func removeAccentsInSearch() -> String {
        
        let okayChars : Set<Character> =
            Set("abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLKMÑNOPQRSTUVWXYZ1234567890 ")
        return String(self.folding(options: .diacriticInsensitive, locale: nil).filter {okayChars.contains($0) })
    }
}

extension UIView {
    
    func setGradientBackground(_ colors:[UIColor]) {
        
        let colorStart = colors[0]
        let colorEnd = colors[1]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorStart.cgColor,colorEnd.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImageView {
    
    func setupImage(photoUrl: String?) {
        
        if let photoUrlString = photoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            
            self.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "pokemon"))
        }
    }
    
}

extension UITableView {
    func getReusableCell<T: UITableViewCell>(
        byIdentifier identifier: String? = nil
    ) -> T! {
        let identifier = identifier ?? String(describing: T.self)

        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            print("Could not dequeue cell with identifier: \(identifier)")
            return T()
        }

        return cell
    }
}



