//
//  TitleLabel.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
