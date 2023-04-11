//
//  Network.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

class Network {
    private let baseURL : String = "https://pokeapi.co/api/v2/pokemon"
    
    func getPokemonList(completionHandler: @escaping (PokemonList) -> Void){
        // TODO: Add limit and offset to fetch batches of pokemons
        let url = URL(string: "\(self.baseURL)?limit=10")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemonList = try? JSONDecoder().decode(PokemonList.self, from: data) {
                    completionHandler(pokemonList)
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
                    completionHandler(pokemon)
                } else {
                    print("Pokemon: Invalid Response")
                }
            } else if let error = error {
                print("Pokemon HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    func getPokemonDetail(name: String, completionHandler: @escaping (PokemonDetail) -> Void){
        let url = URL(string: "\(self.baseURL)-species/\(name)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemonDetail = try? JSONDecoder().decode(PokemonDetail.self, from: data) {
                        completionHandler(pokemonDetail)
                    } else {
                        print("Pokemon detail: Invalid Response")
                    }
                } else if let error = error {
                    print("Pokemon detail HTTP Request Failed \(error)")
                }
            }
        task.resume()
        }
    }

