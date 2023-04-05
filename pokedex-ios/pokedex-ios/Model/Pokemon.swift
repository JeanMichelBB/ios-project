//
//  PokemonModel.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

struct Pokemon: Decodable {
    let name : String
    let id : Int
    let weight : Int
}
