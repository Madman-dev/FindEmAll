//
//  AlertContainerView.swift
//  FindEmAll
//
//  Created by Porori on 4/19/24.
//

import UIKit

class AlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // changing borderColor when darkmode
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//            layer.borderColor = UIColor.black.cgColor
//        }
//    }
}
