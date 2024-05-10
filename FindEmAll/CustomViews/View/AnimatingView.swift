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
        configureLayout()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func animate(position: Movement, completion: (() -> Void)?) {
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
    
    func animateFull(position: Movement, completion: (() -> Void)?) {
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
