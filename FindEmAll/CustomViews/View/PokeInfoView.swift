//
//  PokeInfoView.swift
//  FindEmAll
//
//  Created by Porori on 3/12/24.
//

import UIKit

enum PokeData {
    case height
    case weight
    case move
    case type
}

class PokeInfoView: UIView {
    
    let textLabel = PokeBodyLabel(textAlignment: .left)
    let padding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(data: Pokemon, dataType: PokeData) {
        switch dataType {
        case .height:
            textLabel.text = "It is \(data.height.decimalValue())m tall, \(data.height.roundToFeet())\" in feets"
        case .weight:
            textLabel.text = "It weighs \(data.weight.decimalValue())kg"
        case .move:
            textLabel.text = "It learns \(data.moves[0].move.name)"
        case .type:
            let types = data.types.map { $0.type.name }.joined(separator: ", ")
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
        textLabel.text = "테스트"
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            textLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
