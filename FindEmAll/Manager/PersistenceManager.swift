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
    
    // 마주한 포켓몬 ID 저장
    func savePokeData(_ id: Int) {
        var encounteredId = defaults.array(forKey: encounteredKey) as? [Int] ?? []
        
        if !encounteredId.contains(id) {
            encounteredId.append(id)
            defaults.set(encounteredId, forKey: encounteredKey)
        }
    }
    
    // 마주한 포켓몬 ID를 전체 반환
    func fetchEncounteredId() -> [Int] {
        return defaults.array(forKey: encounteredKey) as? [Int] ?? []
    }
}
