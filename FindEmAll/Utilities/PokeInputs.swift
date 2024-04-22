//
//  PokeInputTitle.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import Foundation

enum PokeInputError: String {
    case caughtTitle
    case missedTitle
    case blankTitle
    
    var text: String {
        switch self {
        case .caughtTitle:
            return "You caught it!"
        case .blankTitle:
            return "Make a guess!"
        case .missedTitle:
            return "That was close!"
        }
    }
}
