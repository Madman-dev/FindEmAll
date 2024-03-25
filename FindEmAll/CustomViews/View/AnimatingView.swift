//
//  AnimatingView.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit
enum Movement {
    case up, down
}

class AnimatingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func animate(to position: Movement, completion: (() -> Void)?) {
        switch position {
        case .up:
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.y -= 410
            } completion: { _ in completion?() }
            
        case .down:
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.y += 410
            } completion: { _ in completion?() }
        }
    }
    
    func animateFull(to position: Movement, completion: (() -> Void)?) {
        switch position {
        case .up:
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.y -= UIScreen.main.bounds.height
            } completion: { _ in completion?() }
        case .down:
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.y += UIScreen.main.bounds.height
            } completion: { _ in completion?() }
        }
    }
}
