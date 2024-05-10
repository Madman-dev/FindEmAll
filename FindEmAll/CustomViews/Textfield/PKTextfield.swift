//
//  PKTextfield.swift
//  FindEmAll
//
//  Created by Porori on 3/12/24.
//

import UIKit

class PKTextfield: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withSpace: Bool) {
        self.init(frame: .zero)
        addMargin()
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        backgroundColor = .systemGray4
        
        textColor = .white
        tintColor = .white
        textAlignment = .center
        
        placeholder = "정답을 적어보세요!"
        font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        minimumFontSize = 24
        autocorrectionType = .no
        spellCheckingType = .no
        clearButtonMode = .whileEditing
        
        returnKeyType = .go
    }
    
    private func addMargin() {
        let paddingView = UIView(frame: CGRect(x: 0, y: -10, width: 10, height: 50))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
