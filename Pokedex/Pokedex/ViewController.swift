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
    
    var pokemonList = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let charmander = Pokemon(name: "Charmander", pokedexID: 4)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        parsePokemonCSV()
        for pokemon in pokemonList {
            print("\(pokemon.pokedexID) : \(pokemon.name) ")
        }
    }
    
    // MARK: - Private Methods
    
    private func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                guard let id = Int(row["id"]!) else { return print("Error getting 'id' from CSV string.") }
                guard let name = row["identifier"] else { return print("Error getting 'name' from CSV string.") }
                let pokemon = Pokemon(name: "\(name)", pokedexID: id)
                pokemonList.append(pokemon)
            }
        } catch {
            print("Error initialising CSV class: \(error).")
        }
    }
    
    // MARK: - CollectionView Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCollectionViewCell {
            
            let pokemon = Pokemon(name: pokemonList[indexPath.row].name, pokedexID: pokemonList[indexPath.row].pokedexID)
            
            cell.configureCell(pokemon)
            
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

