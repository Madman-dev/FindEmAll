//
//  Pokemon.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let moves: [Move]
    let sprites: PokemonSprites
    let types: [PokemonTypes]
}
