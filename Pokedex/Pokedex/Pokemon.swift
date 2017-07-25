//
//  Pokemon.swift
//  Pokedex
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

struct Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name.capitalized
        self._pokedexID = pokedexID
    }
}
