//
//  UIView+Ext.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import UIKit

extension UIView {
    func sizeUp(view: UIView) {
        UIView.transition(with: self, duration: 0.5) {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    func sizeDown(view: UIView) {
        UIView.transition(with: self, duration: 0.5) {
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
