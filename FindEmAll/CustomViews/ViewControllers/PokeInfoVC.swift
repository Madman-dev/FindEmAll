//
//  InfoVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

enum PokeData {
    case height
    case weight
    case move
    case type
}

class PokeInfoVC: UIViewController {
    // infoVC에는 더 많은 콘텐츠를 담을 것이기 때문에 infoView를 적용했다.
    let itemInfoView = PokeInfoView()
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layoutUI()
    }
    
    init(pokemon: Pokemon, for displayType: PokeData) {
        super.init(nibName: nil, bundle: nil)
        self.pokemon = pokemon
        
        switch displayType {
        case .height:
            itemInfoView.textLabel.text = "It is \(pokemon.height.updateValue())m tall, \(pokemon.height.roundToFeet())\" in feets"
        case .weight:
            itemInfoView.textLabel.text = "It weighs \(pokemon.weight.updateValue())kg"
        case .move:
            itemInfoView.textLabel.text = "It learns \(pokemon.moves[0].move.name)"
        case .type:
            itemInfoView.textLabel.text = ""
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackground() {
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.backgroundColor = UIColor.white.withAlphaComponent(0.9).cgColor
    }
    
    private func layoutUI() {
        view.addSubview(itemInfoView)
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            itemInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
