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
        closedStack.frame = .zero
        closedStack.axis = .vertical
        closedStack.alignment = .center
        closedStack.distribution = .fill
        closedStack.translatesAutoresizingMaskIntoConstraints = false
        return closedStack
    }()
    
    // properties
    let pokeImage = PokeImageView(frame: .zero)
    let nameLabel = PokeTitleLabel(textAlignment: .center, fontSize: 18)
    let dataLabel = DataDisplayView()
    let dataLabel2 = DataDisplayView()
    
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
            self.dataLabel2.set(item: .captured, text: "몇 개더라..")
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
        stackView.backgroundColor = .yellow
        stackView.addArrangedSubview(pokeImage)
        stackView.addArrangedSubview(nameLabel)
        
        // update from layoutMargin, after iOS 11
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureOpenedStack(show: Bool) {
        if show {
            stackView.addArrangedSubview(dataLabel)
            stackView.addArrangedSubview(dataLabel2)
            
            pokeImage.contentCompressionResistancePriority(for: .horizontal)
            pokeImage.contentCompressionResistancePriority(for: .vertical)
//            nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
            
            NSLayoutConstraint.activate([
                pokeImage.topAnchor.constraint(equalTo: stackView.topAnchor),
                pokeImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                pokeImage.heightAnchor.constraint(equalToConstant: 150),
                
                dataLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                dataLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
            ])
            
            dataLabel.isHidden = false
            dataLabel2.isHidden = false
        } else {
            dataLabel.isHidden = true
            dataLabel2.isHidden = true
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
