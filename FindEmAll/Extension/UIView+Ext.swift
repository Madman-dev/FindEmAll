//
//  UIView+Ext.swift
//  FindEmAll
//
//  Created by Porori on 3/4/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func animateToCenter(of parent: UIView, origin: CGPoint) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.frame.origin.y = parent.frame.size.height/2 - 40
            }
        }
    }
    
    func animateBack(to position: CGPoint) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                self.frame.origin = position
            }
        }
    }
}
