//
//  QuestionView.swift
//  FindEmAll
//
//  Created by Porori on 3/12/24.
//

import UIKit

class InfoView: UIView {
    
    let textLabel = BodyLabel(textAlignment: .left)
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(textLabel)
        textLabel.text = "테스트"
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}