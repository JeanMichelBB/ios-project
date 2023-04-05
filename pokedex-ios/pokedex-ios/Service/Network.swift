//
//  Network.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

class Network {
    func getPokemons(completionHandler: @escaping (Pokemon) -> Void){
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1")!
//        let url = URL(string: "https://bit.ly/3sspdFO")! // WORKS
//        let url = URL(string: "https://pokeapi.glitch.me/v1/pokemon/1")! // WORKS

//        var request = URLRequest(url: url)

//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let pokemons = try? JSONDecoder().decode(Pokemon.self, from: data) {
                    print(pokemons)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}
