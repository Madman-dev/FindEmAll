//
//  DataView.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

enum DisplayItem {
    case seen, captured, type
}

class DataView: UIView {
    
    private let titleLabel = PKTitleLabel(textAlignment: .center, fontSize: 15)
    private let dataLabel = PKBodyLabel(textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLayout()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBorder() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func set(item: DisplayItem, withCount value: Int? = nil, text: String? = nil) {
        switch item {
        case .seen: titleLabel.text = "본 포켓몬 수:"
        case .captured: titleLabel.text = "잡은 포켓몬 수:"
        case .type: titleLabel.text = "타입:"
        }
        
        if let value = value {
            dataLabel.text = String(value)
        } else if let text = text {
            dataLabel.text = text
        }
    }
    
    private func configureLayout() {
        backgroundColor = .white
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
}
