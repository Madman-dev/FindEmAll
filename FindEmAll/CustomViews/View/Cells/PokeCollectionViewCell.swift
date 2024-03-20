//
//  PokeCollectionViewCell.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PokeCollectionViewCell"
    let pokeImage = PokeImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func configureImage() {
        addSubviews(pokeImage)
        pokeImage.layer.borderWidth = 0
        
        NSLayoutConstraint.activate([
            pokeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokeImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
