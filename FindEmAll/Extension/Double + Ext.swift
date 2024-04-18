//
//  Double + Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/18/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
