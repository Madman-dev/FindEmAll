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
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
