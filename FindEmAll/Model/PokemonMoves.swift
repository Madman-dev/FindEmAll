//
//  PokemonMoves.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

extension Pokemon {
    struct Move: Codable {
        let move: Species
        let versionGroupDetails: [VersionGroupDetail]
    }
    
    struct Species: Codable {
        let name: String
        let url: URL
    }
    
    struct VersionGroupDetail: Codable {
        let levelLearnedAt: Int
        let versionGroup, moveLearnMethod: Species
    }
}
