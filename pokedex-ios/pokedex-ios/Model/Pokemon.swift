//
//  PokemonModel.swift
//  pokedex-ios
//
//  Created by vampirito on 2023-04-02.
//

import Foundation

struct Pokemon: Decodable {
//    let title: String
//    let author: String
    
//    public var count : Int
//    public var name : String
//    public var type : [String]
//    public var img : String
//    public var description : String
    
//    let base_hapiness : Int
    let name : String
    let id : Int
    let weight : Int
    
//    let number : String
//    let name : String
//    let species : String

//    let count: Int?
//    let next: String?
//    let results: [Results]
    
//    init(id: Int, name: String, type: [String], img: String, description: String) {
//        self.id = id
//        self.name = name
//        self.type = type
//        self.img = img
//        self.description = description
//    }
}

struct Results: Decodable {
    let name: String?
    let url: String?
}
