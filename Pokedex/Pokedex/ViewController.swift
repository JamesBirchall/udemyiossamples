//
//  ViewController.swift
//  Pokedex
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var musicIconImageView: UIImageView!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    // MARK: - Private Variables
    
    fileprivate var pokemonList = [Pokemon]()
    fileprivate var filteredPokemonList = [Pokemon]()
    private var audioPlayer: AVAudioPlayer!
    fileprivate var inSearchMode = false
    fileprivate let showPokemonDetail = "showPokemonDetail"

    // MARK: - ViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAudio()
        initTouchOnMusicIconImageView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        pokemonSearchBar.delegate = self
        pokemonSearchBar.returnKeyType = .done
        
        parsePokemonCSV()
        for pokemon in pokemonList {
            print("\(pokemon.pokedexID) : \(pokemon.name) ")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO - Add Code to setup and send object to new viewController
        if segue.identifier == showPokemonDetail {
            if let pokemonDetailViewController = segue.destination as? PokemonDetailViewController {
                if let pokemon = sender as? Pokemon {
                    pokemonDetailViewController.pokemon = pokemon
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: ".mp3")!
        let urlPath = URL(string: path)!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print("Error creating AVAudioPlayer: \(error)")
        }
    }
    
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
    
    private func initTouchOnMusicIconImageView() {
        let tapGestureRegocogniser = UITapGestureRecognizer(target: self, action: #selector(musicIconPressed(gestureRecogniser:)))
        musicIconImageView.isUserInteractionEnabled = true
        musicIconImageView.addGestureRecognizer(tapGestureRegocogniser)
    }
    
    func musicIconPressed(gestureRecogniser: UITapGestureRecognizer) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            musicIconImageView.alpha = 0.4
        } else {
            audioPlayer.play()
            musicIconImageView.alpha = 1
        }
    }
    

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemonList.count
        } else {
            return pokemonList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCollectionViewCell {
            var pokemon: Pokemon
            if inSearchMode {
                pokemon = filteredPokemonList[indexPath.row]
            } else {
                pokemon = pokemonList[indexPath.row]
            }
            
            cell.configureCell(pokemon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // MARK: - COllectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon
        
        if inSearchMode {
            pokemon = filteredPokemonList[indexPath.row]
        } else {
            pokemon = pokemonList[indexPath.row]
        }
        
        performSegue(withIdentifier: showPokemonDetail, sender: pokemon)
    }
    
    // MARK: - CollectionViewFlowLayoutDelegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/3.2)
        
        return size
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
        } else {
            inSearchMode = true
            let searchTextLowecased = searchBar.text!.lowercased().capitalized
            filteredPokemonList = pokemonList.filter({ (poke: Pokemon) -> Bool in
                // conditions
                if poke.name.range(of: "\(searchTextLowecased)") != nil {
                    return true
                }
                return false
            })
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
