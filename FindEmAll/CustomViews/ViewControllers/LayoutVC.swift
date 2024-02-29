//
//  LayoutVC.swift
//  FindEmAll
//
//  Created by Porori on 2/29/24.
//

//import UIKit
//
//class LayoutVC: UIViewController {
//    
//    let actionButton = PokeButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        layoutUI()
//    }
//    
//    func setBackground(color: String) {
//        view.backgroundColor = UIColor(named: color)
//    }
//    
//    private func layoutUI() {
//        view.addSubview(actionButton)
//        
//        NSLayoutConstraint.activate([
//            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    private func configureButton() {
//        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
//    }
//    
//    @objc func actionButtonTapped() {
//        print("버튼이 눌렸습니다.")
//    }
//}
