//
//  Network.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

class Network {
    private let baseURL : String
    private let pokemonList : [Pokemon]?

    init(){
        self.baseURL = "https://pokeapi.co/api/v2/pokemon"
        self.pokemonList = []
    }
    
    func getPokemonList(completionHandler: @escaping (PokemonList) -> Void){
        
        let url = URL(string: "\(self.baseURL)?limit=151")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemonList = try? JSONDecoder().decode(PokemonList.self, from: data) {
//                    self.getPokemon(pokem)
                    print(pokemonList)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    func getPokemon(name : String, completionHandler: @escaping (Pokemon) -> Void){
        let url = URL(string: "\(self.baseURL)/\(name)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) {
                    print(pokemon)
                } else {
                    print("Pokemon: Invalid Response")
                }
            } else if let error = error {
                print("Pokemon HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}
