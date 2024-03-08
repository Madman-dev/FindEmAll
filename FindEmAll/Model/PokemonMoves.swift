//
//  PokemonMoves.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

extension Pokemon {
    struct Move: Decodable {
        let move: Species
    }
    
    struct Species: Decodable {
        let name: String
        let url: String
    }
}
