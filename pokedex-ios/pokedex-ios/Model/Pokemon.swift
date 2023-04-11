//
//  PokemonModel.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Decodable {
    let height: Int
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
    let weight: Int
}

// MARK: - Sprites
struct PokemonSprites: Decodable {
    let frontDefaultMini: String
    let other: Other
    
    private enum CodingKeys: String, CodingKey {
        case frontDefaultMini = "front_default"
        case other
    }
}

// MARK: - Other
struct Other: Decodable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - PokemonType
struct PokemonType: Decodable {
    let slot: Int
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Decodable {
    let name: String
    let url: String
}

// MARK: - TypeType
struct PokemonAbility: Codable {
    let ability: Ability
    
    struct Ability: Codable {
        let name: String
        let url: String
    }
}
