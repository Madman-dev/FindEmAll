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
    let nameLabel = TitleLabel(textAlignment: .center, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
    }
    
    func set(data: Pokemon) {
        DispatchQueue.main.async {
            self.nameLabel.text = data.name
            self.pokeImage.downloadImageUrl(from: data.sprites.frontDefault)
        }
    }
        
    private func configure() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func configureImage() {
        addSubview(pokeImage)
        addSubview(nameLabel)
        
        nameLabel.text = "실험"
        
        NSLayoutConstraint.activate([
            pokeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokeImage.heightAnchor.constraint(equalToConstant: 40),
            pokeImage.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: pokeImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
