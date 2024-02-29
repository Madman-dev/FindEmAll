//
//  PokeButton.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class PokeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, image: String) {
        self.init(frame: .zero)
        set(color: color, withImage: image)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 50
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func set(color: UIColor, withImage image: String) {
        configuration?.image = UIImage(systemName: image)
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .all
        
        backgroundColor = color
    }
}
