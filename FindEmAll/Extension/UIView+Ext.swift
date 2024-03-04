//
//  UIView+Ext.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import UIKit

extension UIView {
    func scaleBigger(view: UIView) {

        view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    func scaleSmaller(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}
