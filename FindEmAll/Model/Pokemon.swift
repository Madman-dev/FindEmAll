//
//  Pokemon.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let moves: [Move] // need to update model
}
