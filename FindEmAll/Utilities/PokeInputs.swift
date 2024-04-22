//
//  PokeInputTitle.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import Foundation

enum PokeInputTitle: String {
    case correctTitle
    case wrongTitle
    case noValue
    
    var text: String {
        switch self {
        case .correctTitle:
            return "You caught it!"
        case .noValue:
            return "Make a guess!"
        case .wrongTitle:
            return "That was close!"
        }
    }
}
