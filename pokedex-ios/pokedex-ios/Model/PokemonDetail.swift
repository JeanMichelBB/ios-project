//
//  PokemonDetail.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-11.
//

import Foundation

// MARK: - Welcome
struct PokemonDetail: Codable {
    let color: Color
    let flavorTextEntries: [FlavorTextEntry]
    let generation: Generation
    let habitat: Habitat
    let shape: Shape

    enum CodingKeys: String, CodingKey {
        case color = "color" 
        case flavorTextEntries = "flavor_text_entries"
        case generation = "generation"
        case habitat = "habitat"
        case shape = "shape"
    }
}

// MARK: - Color
struct Color: Codable {
    let name: String
}
// MARK: - Generation
struct Generation: Codable {
    let name: String
}
// MARK: - Habitat
struct Habitat: Codable {
    let name: String
}
// MARK: - Shape
struct Shape: Codable {
    let name: String
}
// MARK: - Language
struct Language: Codable {
    let name: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Language

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}
