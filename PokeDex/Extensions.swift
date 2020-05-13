//
//  Extensions.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation

extension String {
  
    func removeAccentsInSearch() -> String {
        
        let okayChars : Set<Character> =
            Set("abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLKMÑNOPQRSTUVWXYZ1234567890 ")
        return String(self.folding(options: .diacriticInsensitive, locale: nil).filter {okayChars.contains($0) })
    }
}
