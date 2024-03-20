//
//  PokeButton.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class PokeButton: UIButton {
    enum Size {
        case smaller, bigger
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        set(color: color)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 50
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 8
        
        // 잘못된 적용방식 - giving a value of the height and width limits the use of the button
//        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 101),
//            widthAnchor.constraint(equalToConstant: 101)
//        ])
    }
    
    private func set(color: UIColor) {
        backgroundColor = color
    }
    
    func scale(size: Size) {
        switch size {
        case .bigger:
            sizeUp(view: self)
        case .smaller:
            sizeDown(view: self)
        }
    }
}
