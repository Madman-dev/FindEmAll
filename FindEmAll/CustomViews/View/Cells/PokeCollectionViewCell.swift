//
//  PokeCollectionViewCell.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "PokeCollectionViewCell"
    
    // cell in closed state
    var stackView: UIStackView = {
        let closedStack = UIStackView()
        closedStack.axis = .vertical
        closedStack.alignment = .center
        closedStack.distribution = .fill
        closedStack.translatesAutoresizingMaskIntoConstraints = false
        return closedStack
    }()
    
    // properties
    let pokeImage = PokeImageView(frame: .zero)
    let nameLabel = PokeTitleLabel(textAlignment: .center, fontSize: 16)
    let dataLabel = DataDisplayView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureClosedStack()
    }
    
    func set(data: Pokemon) {
        DispatchQueue.main.async {
            self.backgroundColor = .white
            self.nameLabel.text = data.name
            self.dataLabel.set(item: .type, text: "빈 칸")
            self.pokeImage.downloadImageUrl(from: data.sprites.frontDefault)
        }
    }
    
    private func configureLayout() {
        backgroundColor = .clear
        layer.cornerRadius = 10
    }
    
    // NO distribution == no nameLabel
    private func configureClosedStack() {
        addSubviews(stackView)
        stackView.addArrangedSubview(pokeImage)
        stackView.addArrangedSubview(nameLabel)
        
        pokeImage.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // update from layoutMargin, after iOS 11
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureOpenedStack(show: Bool) {
        if show {
            stackView.addArrangedSubview(dataLabel)
            stackView.distribution = .fillProportionally
            
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                
                pokeImage.topAnchor.constraint(equalTo: stackView.topAnchor),
                pokeImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                
                dataLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                dataLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            ])
            
            dataLabel.isHidden = false
        } else {
            dataLabel.isHidden = true
        }
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
