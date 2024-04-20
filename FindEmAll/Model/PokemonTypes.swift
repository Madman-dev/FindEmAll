//
//  PokemonTypes.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

extension Pokemon {
    struct PokemonTypes: Decodable {
        let slot: Int
        let type: PokemonType
    }
    
    struct PokemonType: Decodable {
        let name: String
        let url: URL
    }
}
