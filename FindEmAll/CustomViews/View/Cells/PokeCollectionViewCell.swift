//
//  PokeCollectionViewCell.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PokeCollectionViewCell"
    // MARK: - expanded State
    private var expandedConstraint: NSLayoutConstraint!
    
    // MARK: - collapsed State
    private var collapsedConstraint: NSLayoutConstraint!
    
    let pokeImage = ImageView(frame: .zero)
    let nameLabel = TitleLabel(textAlignment: .center, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureImage()
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    func set(data: Pokemon) {
        DispatchQueue.main.async {
            self.backgroundColor = .white.withAlphaComponent(0.7)
            self.bringSubviewToFront(self.pokeImage)
            self.bringSubviewToFront(self.nameLabel)
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
        
        NSLayoutConstraint.activate([
            pokeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokeImage.heightAnchor.constraint(equalToConstant: 40),
            pokeImage.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: pokeImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    //MARK: - when cell selection state changes, toggle constraint and animate the rotation of the arrow
    private func updateAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
        
        // animating the arrow image - which I don't have
    }
    
    override func prepareForReuse() {
        pokeImage.image = nil
        nameLabel.text = nil
        backgroundColor = .white.withAlphaComponent(0.7)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
