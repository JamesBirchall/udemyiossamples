//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokemonName.text = pokemon.name
        thumbImage.image = UIImage(named: "\(pokemon.pokedexID)")
    }
}
