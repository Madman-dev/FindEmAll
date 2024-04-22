//
//  PokeInfoView.swift
//  FindEmAll
//
//  Created by Porori on 3/12/24.
//

import UIKit

class PokeInfoView: UIView {
    
    let textLabel = PokeBodyLabel(textAlignment: .left)
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addSubview(textLabel)
        textLabel.text = "테스트"
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            textLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
