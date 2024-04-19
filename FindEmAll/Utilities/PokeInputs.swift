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
    
    var text: String {
        switch self {
        case .correctTitle:
            return "Congrats!"
        case .wrongTitle:
            return "Nearly got it"
        }
    }
}

enum PokeInputMessage {
    case correctMessage
    case wrongMessage
    
    var text: String {
        switch self {
        case .correctMessage:
            return "You caught the Pokemon!"
        case .wrongMessage:
            return "Think one more time"
        }
    }
}
