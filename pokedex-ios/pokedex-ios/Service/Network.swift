//
//  Network.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

class Network {
    private let baseURL : String = "https://pokeapi.co/api/v2/pokemon"
    private var cachedPokemon : Pokemon?
    
    func getPokemonList(offset: Int, limit: Int, completionHandler: @escaping (Result<[PokemonListItem], Error>) -> Void){
        let url = URL(string: "\(self.baseURL)?limit=\(limit)&offset=\(offset)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemonList = try? JSONDecoder().decode(PokemonList.self, from: data) {
                    completionHandler(.success(pokemonList.results))
                } else {
                    completionHandler(.failure(error!.localizedDescription as! Error))
                }
            } else if let error = error {
                completionHandler(.failure(error.localizedDescription as! Error))
            }
        }
        task.resume()
    }
    
    func getPokemon(name : String, completionHandler: @escaping (Result<Pokemon, Error>) -> Void){
        if let cachedPokemon = cachedPokemon {
            completionHandler(.success(cachedPokemon))
            return
        }
        let url = URL(string: "\(self.baseURL)/\(name)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) {
                    self.cachedPokemon = pokemon
                    completionHandler(.success(pokemon))
                } else {
                    completionHandler(.failure(error!.localizedDescription as! Error))
                }
            } else if let error = error {
                completionHandler(.failure(error.localizedDescription as! Error))
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

