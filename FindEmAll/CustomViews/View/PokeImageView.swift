//
//  PokeView.swift
//  FindEmAll
//
//  Created by Porori on 3/14/24.
//

import UIKit

class PokeImageView: UIView {
    let pokeImage = ImageView(withImage: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: String) {
        pokeImage.image = UIImage(systemName: image)
    }
    
    private func configure() {
        clipsToBounds = true
        layer.borderWidth = 8
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(pokeImage)
        NSLayoutConstraint.activate([
            pokeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            pokeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            pokeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            pokeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    // provide value of the frame AFTER its been initialized within another VC.
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.width/2
    }
}
