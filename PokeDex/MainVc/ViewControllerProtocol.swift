//
//  ViewControllerProtocol.swift
//  PokeDex
//
//  Created by Giovanny Piñeros on 13/05/20.
//  Copyright © 2020 Giovanny Piñeros. All rights reserved.
//

import Foundation
protocol ViewControllerProtocol:class {
    func getPokemons(_ pokemons:[Pokemon], isFromSearchQuery: Bool)
    func showLoader()
    func hideLoader()
    func showReloadButton()
    func hideReloadButton()
    func showError(_ error:String)
}
