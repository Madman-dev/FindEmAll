//
//  PokeCollectionViewCell.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PokeCollectionViewCell"
    let pokeImage = ImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
    }
    
    func changeImage(to image: String) {
        pokeImage.set(img: image)
    }
    
    private func configure() {
        backgroundColor = .clear
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
