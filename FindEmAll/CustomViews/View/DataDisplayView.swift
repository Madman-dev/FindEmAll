//
//  DataDisplayView.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

enum DisplayItem {
    case seen, captured
}

class DataDisplayView: UIView {
    
    private let titleLabel = PokeTitleLabel(textAlignment: .center, fontSize: 15)
    private let dataLabel = PokeBodyLabel(textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLayout()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabels() {
        addSubviews(titleLabel, dataLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            dataLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func set(item: DisplayItem, withCount count: Int) {
        switch item {
        case .seen:
            titleLabel.text = "본 포켓몬 수:"
        case .captured:
            titleLabel.text = "잡은 포켓몬 수:"
        }
        
        dataLabel.text = String(count)
    }
}
