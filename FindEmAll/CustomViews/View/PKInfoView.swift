//
//  PKInfoView.swift
//  FindEmAll
//
//  Created by Porori on 3/12/24.
//

import UIKit

enum PKData {
    case height
    case weight
    case move
    case type
}

class PKInfoView: UIView {
    
    let textLabel = PKBodyLabel(textAlignment: .left)
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(data: Pokemon, dataType: PKData) {
        let decimalHeight = data.height.valueInDecimal()
        let heightRoundedDown = data.height.roundToFeet()
        let decimalWeight = data.weight.valueInDecimal()
        let types = data.types.map { $0.type.name }.joined(separator: ", ")
        
        switch dataType {
        case .height:
            textLabel.text = "It is \(decimalHeight)m tall, \(heightRoundedDown)\" in feets"
        case .weight:
            textLabel.text = "It weighs \(decimalWeight)kg"
        case .move:
            textLabel.text = "It learns \(data.moves[0].move.name)"
        case .type:
            textLabel.text = "It is \(types) type"
        }
    }
    
    private func configureLayout() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.9).cgColor
    }
    
    private func configureAutoLayout() {
        addSubview(textLabel)
        textLabel.text = "updating data..."
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            textLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
