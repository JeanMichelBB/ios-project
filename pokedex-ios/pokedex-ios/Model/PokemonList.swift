//
//  PokemonList.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Decodable {
    let results: [PokemonListItem]
}

// MARK: - Result
struct PokemonListItem: Decodable {
    let name: String
    let url: String
}
