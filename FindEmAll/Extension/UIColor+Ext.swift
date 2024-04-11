//
//  UIColor+Ext.swift
//  FindEmAll
//
//  Created by Porori on 4/11/24.
//

import UIKit

extension UIColor {
    
    // convert Hexcode to UIColor
    convenience init(hexCode: String) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            // 처음 데이터를 버리는 이유는? > '#'를 제거하기 위함
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "해당 코드는 Hexcode가 아니에요!")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        // why use bits to go over red and green, but not blue?
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat((rgbValue & 0x0000FF)) / 255.0,
                  alpha: 1.0)
    }
}
