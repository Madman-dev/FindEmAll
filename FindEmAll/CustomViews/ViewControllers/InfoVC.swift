//
//  InfoVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

import UIKit

class InfoVC: UIViewController {
    
    let textLabel = BodyLabel(textAlignment: .left)
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        configureLabel()
    }
    
    private func configureLabel() {
        view.addSubview(textLabel)
        textLabel.text = "정보를 공유합니다."
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
