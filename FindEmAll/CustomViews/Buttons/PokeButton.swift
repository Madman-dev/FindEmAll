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
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        set(color: color)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    func addBorder(color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 8
    }
    
    private func set(color: UIColor) {
        backgroundColor = color
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
