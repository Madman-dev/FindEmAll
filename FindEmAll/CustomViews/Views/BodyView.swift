//
//  BodyLabel.swift
//  FindEmAll
//
//  Created by Porori on 2/28/24.
//

import UIKit

enum DataType {
    case name, type, form
}

class BodyView: UIView {
    let bodyLabel = TitleLabel(textAlignment: .left, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(bodyLabel)
                
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func set(DataType: DataType) {
        switch DataType {
        case .name:
            bodyLabel.text = "이름은 000입니다."
        case .type:
            bodyLabel.text = "타입은 000입니다."
        case .form:
            bodyLabel.text = "폼은 000입니다."
        }
    }
}
