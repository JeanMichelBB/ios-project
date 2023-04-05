//
//  PokemonModel.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let height, id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

// MARK: - Sprites
struct Sprites: Codable {
    let other: Other
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Codable {
    let name: String
    let url: String
}
