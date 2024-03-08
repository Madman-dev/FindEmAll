//
//  BodyLabel.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class BodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        textColor = .secondaryLabel
    }
}
