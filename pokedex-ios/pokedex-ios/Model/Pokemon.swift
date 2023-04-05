//
//  PokemonModel.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Decodable {
    let height, id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

// MARK: - Sprites
struct Sprites: Decodable {
    let front_default : String
    let other: Other
}

// MARK: - Other
struct Other: Decodable {
    let dreamWorld: DreamWorld

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Decodable {
    let slot: Int
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Decodable {
    let name: String
    let url: String
}
