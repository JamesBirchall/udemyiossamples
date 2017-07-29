//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by James Birchall on 28/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailViewController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var musicIconImageView: UIImageView!
    @IBOutlet weak var backIconImageView: UIImageView!
    
    @IBOutlet weak var pokemonMainImageView: UIImageView!
    @IBOutlet weak var pokemonDescriptionTextView: UITextView!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonDefenceLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonBaseAttackLabel: UILabel!
    
    @IBOutlet weak var pokemonNextEvolutionLabel: UILabel!
    @IBOutlet weak var pokemonCurrentEvolutionImageView: UIImageView!
    @IBOutlet weak var pokemonNextEvolutionImageView: UIImageView!
    
    // MARK: - Private Variables
    private var _pokemon: Pokemon!
    private var _audioPlayer: AVAudioPlayer!
    fileprivate let showPokemonDetail = "showPokemonDetail"
    
    // MARK: - Public Variables
    var pokemon: Pokemon {
        get {
            return _pokemon
        }
        set {
            _pokemon = newValue
        }
    }
    
    var audioPlayer: AVAudioPlayer {
        get {
            return _audioPlayer
        }
        set {
            _audioPlayer = newValue
        }
    }
    
    // MARK: - ViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTouchOnMusicIconImageView()
        initTouchOnBackIconImageView()
        
        if !audioPlayer.isPlaying {
            musicIconImageView.alpha = 0.4
        }
        
        pokemonNameLabel.text = _pokemon.name
        pokemonIDLabel.text = "\(_pokemon.pokedexID)"
        pokemonMainImageView.image = UIImage(named: "\(_pokemon.pokedexID)")
        pokemonCurrentEvolutionImageView.image = UIImage(named: "\(_pokemon.pokedexID)")
    }
    
    // MARK: - Private Methods
    
    private func initTouchOnMusicIconImageView() {
        let tapGestureRegocogniser = UITapGestureRecognizer(target: self, action: #selector(musicIconPressed(gestureRecogniser:)))
        musicIconImageView.isUserInteractionEnabled = true
        musicIconImageView.addGestureRecognizer(tapGestureRegocogniser)
    }
    
    private func initTouchOnBackIconImageView() {
        let tapGestureRegocogniser = UITapGestureRecognizer(target: self, action: #selector(backIconPressed(gestureRecogniser:)))
        backIconImageView.isUserInteractionEnabled = true
        backIconImageView.addGestureRecognizer(tapGestureRegocogniser)
    }
    
    // MARK: - Public Methods
    
    func musicIconPressed(gestureRecogniser: UITapGestureRecognizer) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            musicIconImageView.alpha = 0.4
        } else {
            audioPlayer.play()
            musicIconImageView.alpha = 1
        }
    }
    
    func backIconPressed(gestureRecogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
