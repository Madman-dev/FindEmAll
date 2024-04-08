//
//  PersistenceValidator.swift
//  FindEmAll
//
//  Created by Porori on 4/8/24.
//

import Foundation

class PersistenceValidator {
    func hasSavedData(id: Int, testingNumber: Int) -> Bool {
        var returnValue = false
        
        if id == testingNumber { returnValue = true }
        return returnValue
    }
}
