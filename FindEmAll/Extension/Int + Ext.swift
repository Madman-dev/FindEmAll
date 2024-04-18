//
//  Int + Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/18/24.
//

import Foundation

extension Int {
    func updateValue() -> Double {
        return Double(self)/10
    }
    
    func roundToFeet() -> Double {
        return ((Double(self)/10) * 3.28084).rounded(toPlaces: 2)
    }
}
