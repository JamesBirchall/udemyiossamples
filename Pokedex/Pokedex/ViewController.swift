//
//  ViewController.swift
//  Pokedex
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let charmander = Pokemon(name: "Charmander", pokedexID: 4)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - CollectionView Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // MARK: - COllectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TO DO ADD CODE HERE ON SELECTION
    }
    
    // MARK: - CollectionViewFlowLayoutDelegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/3.2)
        
        return size
    }
}

