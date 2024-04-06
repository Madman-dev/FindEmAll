//
//  PersistenceManager.swift
//  FindEmAll
//
//  Created by Porori on 4/6/24.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private let defaults = UserDefaults.standard
    private let encounteredKey = "EncounteredKey"
    private init() {}
    
    func savePokeData(_ id: Int) {
        var encounteredId = defaults.array(forKey: encounteredKey) as? [Int] ?? []
        print("처음 마주한 ID: \(encounteredId)")
        
        if !encounteredId.contains(id) {
            encounteredId.append(id)
            print("저장된 ID: \(encounteredId)")
            defaults.set(encounteredId, forKey: encounteredKey)
        }
    }
    
    func fetchEncounteredId() -> [Int] {
        return defaults.array(forKey: encounteredKey) as? [Int] ?? []
    }
}
