//
//  DataDisplayView.swift
//  FindEmAll
//
//  Created by Porori on 3/20/24.
//

import UIKit

class DataDisplayView: UIView {
    
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 25)
    let dataLabel = BodyLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        configureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        titleLabel.text = "제목"
        dataLabel.text = "테스트"
    }
    
    private func configureLabels() {
        addSubviews(titleLabel, dataLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            dataLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
