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
    
    func tapAnimation(_ completion: @escaping () -> Void) {
        isUserInteractionEnabled = false
        let originalSize = self.frame.size
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            [weak self] in
            guard let self = self else { return }
            let scaleValue: CGFloat = 0.95
            let scaledSize = CGSize(width: originalSize.width * scaleValue, height: originalSize.height * scaleValue)
            let translation = CGPoint(x: (originalSize.width - scaledSize.width), y: (originalSize.height - scaledSize.height))
            
            let transform = CGAffineTransform.identity
                .translatedBy(x: translation.x, y: translation.y)
                .scaledBy(x: scaleValue, y: scaleValue)
            self.transform = transform
            
        }) { (done) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                [weak self] in
                self?.transform = .identity
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completion()
            }
        }
    }
}
