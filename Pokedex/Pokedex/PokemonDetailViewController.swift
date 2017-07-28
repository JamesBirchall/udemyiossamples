//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by James Birchall on 28/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    // MARK: - Private Variables
    private var _pokemon: Pokemon!
    
    // MARK: - Public Variables
    var pokemon: Pokemon {
        get {
            return _pokemon
        }
        set {
            _pokemon = newValue
        }
    }
    
    // MARK: - ViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonNameLabel.text = _pokemon.name
    }
}
