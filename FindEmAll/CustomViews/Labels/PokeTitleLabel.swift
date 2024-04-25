//
//  PokeTitleLabel.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class PokeTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        self.numberOfLines = 0
    }
    
    private func configureLayout() {
        textColor = .label
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
