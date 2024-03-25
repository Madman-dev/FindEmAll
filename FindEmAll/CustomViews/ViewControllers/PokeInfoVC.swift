//
//  InfoVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class PokeInfoVC: UIViewController {
    // infoVC에는 더 많은 콘텐츠를 담을 것이기 때문에 infoView를 적용했다.
    let itemInfoView = PokeInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layoutUI()
    }
    
    func set(text: String) {
        itemInfoView.textLabel.text = text
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
