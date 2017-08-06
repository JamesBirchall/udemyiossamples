//
//  Pokemon.swift
//  Pokedex
//
//  Created by James Birchall on 23/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

class Pokemon {
    
    // MARK: - Private Variables
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    fileprivate var _description: String!
    fileprivate var _type: String = ""
    fileprivate var _height: Int!
    fileprivate var _weight: Int!
    fileprivate var _attack: Int!
    fileprivate var _defense: Int!
    fileprivate var _nextEvolution = ""
    fileprivate var _nextEvolutionPokedexID = 0
    private var pokemonURL: String!
    fileprivate var _descriptionsURL: String!
    
    // MARK: - Public Variables
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var type: String {
        get {
            return _type
        }
        set {
            _type += newValue
        }
    }
    
    var nextEvolution: String {
        get {
            return _nextEvolution
        }
        set {
            _nextEvolution = newValue
        }
    }
    
    var nextEvolutionPokedexID: Int {
        get {
            return _nextEvolutionPokedexID
        }
        set {
            _nextEvolutionPokedexID = newValue
        }
    }
    
    var height: Int {
        return _height
    }
    
    var weight: Int {
        return _weight
    }
    
    var attack: Int {
        return _attack
    }
    
    var defense: Int {
        return _defense
    }
    
    var description: String {
        return _description
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name.capitalized
        self._pokedexID = pokedexID
        
        pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexID)"
    }
    
    // MARK: - Public Functions
    
    func downloadPokemonDetails(completed: @escaping () -> ()) {
        if let url = URL(string: pokemonURL) {
            
            print("\(url)")
            let pokemonDataSession = URLSession(configuration: .default)
            pokemonDataSession.dataTask(with: url, completionHandler: {
                (data, response, error) in
                //print("Response has come back for : \(url)")
                
                if error != nil {
                    print("Download Failed: \(error!.localizedDescription)")
                    return
                }
                
                // print(response.debugDescription)
                
                guard let dataAsString = String(data: data!, encoding: .utf8) else {
                    print("Failed to convert Data to String.")
                    return
                }
                
                if let jsonObject = dataAsString.toJSON() {
                    // print(jsonObject)
                    
                    if let convertedJsonObject = jsonObject as? Dictionary<String, Any> {
                        
                        // Get Data out for the Pokemon
                        if let attack = convertedJsonObject["attack"] as? Int {
                            self._attack = attack
                        }
                        if let defense = convertedJsonObject["defense"] as? Int {
                            self._defense = defense
                        }
                        if let height = convertedJsonObject["height"] as? String {
                            self._height = Int(height)
                        }
                        if let weight = convertedJsonObject["weight"] as? String {
                            self._weight = Int(weight)
                        }
                        
                        // Get the type which comes as an array of Dictionarys
                        if let types = convertedJsonObject["types"] as? [Dictionary<String, Any>] {
                            for (index, type) in types.enumerated() {
                                if index == (types.count - 1) {
                                    if let typeName = type["name"] as? String {
                                        self.type = typeName.capitalized
                                    }
                                } else {
                                    if let typeName = type["name"] as? String {
                                        self.type = "\(typeName.capitalized) / "
                                    }
                                }
                                
                            }
                        }
                        
                        // Get the description which requires a 2nd download Task and URL to be created
                        if let descriptionsArray = convertedJsonObject["descriptions"] as? [Dictionary<String, Any>] {
                            if let firstURL = descriptionsArray.first {
                                if let descriptionURLPart = firstURL["resource_uri"] as? String {
                                    self._descriptionsURL = "\(URL_BASE)\(descriptionURLPart)"
                                }
                            }
                        }
                        
                        // Get Next Evolution 
                        if let evolutionData = convertedJsonObject["evolutions"] as? [Dictionary<String, Any>] {
                            if let evolutionNext = evolutionData.first {
                                if let evolutionName = evolutionNext["to"] as? String {
                                    self.nextEvolution = "Next Evo: \(evolutionName) "
                                }
                                
                                if let evolutionLevel = evolutionNext["level"] as? Int {
                                    self.nextEvolution += "lvl \(evolutionLevel)"
                                }
                                if let resourceURI = evolutionNext["resource_uri"] as? String {
                                    var parts = resourceURI.components(separatedBy: "/")
                                    parts.remove(at: parts.count-1)
                                    if let nextEvolutionID = Int(parts.last!) {
                                        self.nextEvolutionPokedexID = nextEvolutionID
                                    }
                                }
                            } else {
                                self.nextEvolution = "No future evolution"
                            }
                        }
                    }
                    
                }
                
                completed()
            }).resume()
            
        }
    }
    
    func downloadPokemonDescription(completed: @escaping () -> ()) {
        if let descriptionFullURL = URL(string:_descriptionsURL) {
            print("\(descriptionFullURL)")
            let pokemonDescriptionSession = URLSession(configuration: .default)
            pokemonDescriptionSession.dataTask(with: descriptionFullURL, completionHandler: {
                (data, response, error) in
                // print("Response has come back for : \(descriptionFullURL)")
                
                if error != nil {
                    print("Download Failed: \(error!.localizedDescription)")
                    return
                }
                
                guard let dataAsString = String(data: data!, encoding: .utf8) else {
                    print("Failed to convert Data to String.")
                    return
                }
                
                if let jsonObject = dataAsString.toJSON() {
                    // print(jsonObject)
                    
                    if let convertedJsonObject = jsonObject as? Dictionary<String, Any> {
                        
                        if let description = convertedJsonObject["description"] as? String {
                            self._description = description
                        }
                    }
                }
                
                completed()
            }).resume()
        }
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
